// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

// const BITMAP_SIZE: usize = 0x3000;
// const BITMAP_ATOMIC_SIZE: usize = 64;

// type BitmapAtomicType = u64;

// type BitMap([Bitmap])

use alloc::vec::Vec;

use super::util::bit_get;

pub trait BitAlloc {
    // The bitmap has a total of CAP bits, numbered from 0 to CAP-1 inclusively.
    const CAP: usize;

    // The default value. Workaround for `const fn new() -> Self`.
    #[allow(clippy::declare_interior_mutable_const)]
    const DEFAULT: Self;

    // Set a bit.
    fn set(&mut self, idx: usize);

    // Clear a bit
    fn clear(&mut self, idx: usize);

    // Get a bit
    fn get(&self, idx: usize) -> usize;

    // Whether there are free bits remaining
    // fn any(&self) -> bool;
}

// A bitmap of 4K bits
pub type BitAlloc256 = BitMap<BitAlloc16>;
// A bitmap of 4K bits
pub type BitAlloc4K = BitMap<BitAlloc256>;
// A bitmap of 64K bits
pub type BitAlloc64K = BitMap<BitAlloc4K>;
// A bitmap of 1M bits
pub type BitAlloc1M = BitMap<BitAlloc64K>;
// A bitmap of 16M bits
pub type BitAlloc16M = BitMap<BitAlloc1M>;
// A bitmap of 256M bits
pub type BitAlloc256M = BitMap<BitAlloc16M>;

#[repr(C)]
#[derive(Copy, Clone)]
pub struct BitMap<T: BitAlloc> {
    // bitset: u16,
    map: [T; 16],
}

impl<T: BitAlloc> BitMap<T> {
    pub const fn default() -> BitMap<T> {
        BitMap::<T> { map: [T::DEFAULT; 16] }
    }
}

impl<T: BitAlloc> BitAlloc for BitMap<T> {
    const CAP: usize = T::CAP * 16;

    const DEFAULT: Self = BitMap {
        // bitset: 0,
        map: [T::DEFAULT; 16],
    };

    fn set(&mut self, idx: usize) {
        let i = idx / T::CAP;
        self.map[i].set(idx % T::CAP);
        // self.0 = self.0 | (1 << i);
    }

    fn clear(&mut self, idx: usize) {
        let i = idx / T::CAP;
        self.map[i].clear(idx % T::CAP);
        // self.0 = self.0 & (!(1 << idx) & 0xffff);
    }

    fn get(&self, idx: usize) -> usize {
        let i = idx / T::CAP;
        self.map[i].get(idx % T::CAP)
    }
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Eq)]
pub struct BitAlloc16(u16);

impl PartialEq for BitAlloc16 {
    fn eq(&self, other: &Self) -> bool {
        self.0 == other.0
    }
}

impl BitAlloc16 {
    pub const fn default() -> BitAlloc16 {
        BitAlloc16(0)
    }
}

impl BitAlloc for BitAlloc16 {
    const CAP: usize = 16;
    const DEFAULT: Self = BitAlloc16(0);

    fn set(&mut self, idx: usize) {
        self.0 = self.0 | (1 << idx);
    }

    fn clear(&mut self, idx: usize) {
        self.0 = self.0 & (!(1 << idx) & 0xffff);
    }

    fn get(&self, idx: usize) -> usize {
        if self.0 & (1 << idx) != 0 {
            1
        } else {
            0
        }
    }
}

// flex bit map
#[derive(Clone)]
pub struct FlexBitmap {
    pub len: usize,
    pub map: Vec<usize>,
}

impl FlexBitmap {
    pub fn new(len: usize) -> FlexBitmap {
        let map = vec![0; (len + 64 - 1) / 64];
        FlexBitmap { len, map }
    }

    pub fn init_dirty(&mut self) {
        for i in 0..self.map.len() {
            self.map[i] = usize::MAX;
        }
    }

    pub fn clear(&mut self) {
        for i in 0..self.map.len() {
            self.map[i] = 0;
        }
    }

    pub fn get(&self, idx: usize) -> usize {
        if idx > self.len {
            panic!("too large idx {} for get bitmap", idx);
        }
        let val = self.map[idx / 64];
        bit_get(val, idx % 64)
    }

    pub fn set(&mut self, bit: usize, val: bool) {
        if bit > self.len {
            panic!("too large idx {} for set bitmap", bit);
        }
        if val {
            self.map[bit / 64] |= 1 << (bit % 64);
        } else {
            self.map[bit / 64] &= !(1 << (bit % 64));
        }
    }

    pub fn set_bits(&mut self, bit: usize, len: usize, val: bool) {
        if bit + len > self.len {
            panic!("set_bits: too large idx {} for set bitmap", bit);
        }
        // 默认2MB或1KB对齐
        if len == 1 {
            self.set(bit, val);
        } else {
            if bit % 64 != 0 || (bit + len) % 64 != 0 {
                panic!("set_bits: bit start and len should align with 64");
            }

            let mut head = bit;
            while head < (bit + len) {
                self.map[head / 64] = if val { usize::MAX } else { 0 };
                head += 64;
            }
        }
    }

    pub fn slice(&self) -> &[usize] {
        self.map.as_slice()
    }

    pub fn vec_len(&self) -> usize {
        self.map.len()
    }

    pub fn sum(&self) -> usize {
        let mut sum = 0;
        for val in &self.map {
            sum += val.count_ones() as usize;
        }
        sum
    }

    pub fn first(&self) -> usize {
        let mut first = 0;
        for val in &self.map {
            if *val == 0 {
                first += 64;
            } else {
                let mut tmp = *val;
                while (tmp & 1) == 0 {
                    tmp = tmp >> 1;
                    first += 1;
                }
                return first;
            }
        }
        info!("all is 0");
        first
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn bitalloc16() {
        let mut bitmap = BitAlloc16::default();
        let mut value = bitmap.get(11);
        assert_eq!(value, 0);

        bitmap.set(11);
        value = bitmap.get(11);
        assert_eq!(value, 1);

        bitmap.clear(11);
        value = bitmap.get(11);
        assert_eq!(value, 0);
    }

    #[test]
    fn bitalloc256() {
        let mut bitmap = BitAlloc256::default();
        let mut value = bitmap.get(121);
        assert_eq!(value, 0);

        bitmap.set(121);
        value = bitmap.get(121);
        assert_eq!(value, 1);

        bitmap.clear(11);
        value = bitmap.get(121);
        assert_eq!(value, 0);
    }
}
