
target/riscv64gc-unknown-none-elf/debug/hello_world:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
    80200000:	0000b117          	auipc	sp,0xb
    80200004:	00010113          	mv	sp,sp
    80200008:	63c1                	lui	t2,0x10
    8020000a:	00150e13          	add	t3,a0,1
    8020000e:	03c383b3          	mul	t2,t2,t3
    80200012:	911e                	add	sp,sp,t2
    80200014:	00004097          	auipc	ra,0x4
    80200018:	b2a080e7          	jalr	-1238(ra) # 80203b3e <hentry>
	...

0000000080201000 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h741d95d089067998E>:
    80201000:	1101                	add	sp,sp,-32 # 8020afe0 <.LCPI743_1+0xc78>
    80201002:	ec06                	sd	ra,24(sp)
    80201004:	e822                	sd	s0,16(sp)
    80201006:	1000                	add	s0,sp,32
    80201008:	fea43023          	sd	a0,-32(s0)
    8020100c:	feb43423          	sd	a1,-24(s0)
    80201010:	60e2                	ld	ra,24(sp)
    80201012:	6442                	ld	s0,16(sp)
    80201014:	6105                	add	sp,sp,32
    80201016:	8082                	ret

0000000080201018 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next28_$u7b$$u7b$closure$u7d$$u7d$17hc6867185ddbe41b4E>:
    80201018:	1101                	add	sp,sp,-32
    8020101a:	ec06                	sd	ra,24(sp)
    8020101c:	e822                	sd	s0,16(sp)
    8020101e:	1000                	add	s0,sp,32
    80201020:	fea42423          	sw	a0,-24(s0)
    80201024:	fea42623          	sw	a0,-20(s0)
    80201028:	60e2                	ld	ra,24(sp)
    8020102a:	6442                	ld	s0,16(sp)
    8020102c:	6105                	add	sp,sp,32
    8020102e:	8082                	ret

0000000080201030 <_ZN11hello_world9hyp_alloc14heap_allocator9init_heap17h58e6e88e1ffd912eE>:
    80201030:	7175                	add	sp,sp,-144
    80201032:	e506                	sd	ra,136(sp)
    80201034:	e122                	sd	s0,128(sp)
    80201036:	0900                	add	s0,sp,144

0000000080201038 <.Lpcrel_hi0>:
    80201038:	0031a517          	auipc	a0,0x31a
    8020103c:	fc850513          	add	a0,a0,-56 # 8051b000 <_ZN11hello_world9hyp_alloc14heap_allocator14HEAP_ALLOCATOR17h651364cb0432a4f7E>
    80201040:	00004097          	auipc	ra,0x4
    80201044:	97a080e7          	jalr	-1670(ra) # 802049ba <_ZN78_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..ops..deref..Deref$GT$5deref17h7df0c075793b5bd0E>
    80201048:	85aa                	mv	a1,a0
    8020104a:	f8b43023          	sd	a1,-128(s0)
    8020104e:	fca43823          	sd	a0,-48(s0)
    80201052:	fca43c23          	sd	a0,-40(s0)
    80201056:	4585                	li	a1,1
    80201058:	4601                	li	a2,0
    8020105a:	00002097          	auipc	ra,0x2
    8020105e:	6d2080e7          	jalr	1746(ra) # 8020372c <_ZN4core4sync6atomic11AtomicUsize9fetch_add17h2a3f763a88e4912dE>
    80201062:	85aa                	mv	a1,a0
    80201064:	f8b43423          	sd	a1,-120(s0)
    80201068:	fea43023          	sd	a0,-32(s0)
    8020106c:	a009                	j	8020106e <.Lpcrel_hi0+0x36>
    8020106e:	f8043503          	ld	a0,-128(s0)
    80201072:	0521                	add	a0,a0,8
    80201074:	4589                	li	a1,2
    80201076:	00002097          	auipc	ra,0x2
    8020107a:	692080e7          	jalr	1682(ra) # 80203708 <_ZN4core4sync6atomic11AtomicUsize4load17h79eb8912deb096faE>
    8020107e:	f8843583          	ld	a1,-120(s0)
    80201082:	00b50863          	beq	a0,a1,80201092 <.Lpcrel_hi0+0x5a>
    80201086:	a009                	j	80201088 <.Lpcrel_hi0+0x50>
    80201088:	00002097          	auipc	ra,0x2
    8020108c:	74c080e7          	jalr	1868(ra) # 802037d4 <_ZN4core4sync6atomic14spin_loop_hint17h39eb60b027d73982E>
    80201090:	bff9                	j	8020106e <.Lpcrel_hi0+0x36>
    80201092:	f8843583          	ld	a1,-120(s0)
    80201096:	f8043503          	ld	a0,-128(s0)
    8020109a:	00850613          	add	a2,a0,8
    8020109e:	0541                	add	a0,a0,16
    802010a0:	fea43423          	sd	a0,-24(s0)
    802010a4:	fcc43023          	sd	a2,-64(s0)
    802010a8:	fab43c23          	sd	a1,-72(s0)
    802010ac:	fca43423          	sd	a0,-56(s0)
    802010b0:	fc843503          	ld	a0,-56(s0)
    802010b4:	faa43023          	sd	a0,-96(s0)
    802010b8:	fc043503          	ld	a0,-64(s0)
    802010bc:	f8a43c23          	sd	a0,-104(s0)
    802010c0:	fb843503          	ld	a0,-72(s0)
    802010c4:	f8a43823          	sd	a0,-112(s0)
    802010c8:	f9040513          	add	a0,s0,-112
    802010cc:	f6a43c23          	sd	a0,-136(s0)
    802010d0:	00003097          	auipc	ra,0x3
    802010d4:	48a080e7          	jalr	1162(ra) # 8020455a <_ZN79_$LT$spin..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hdc80ca8a5661e4c1E>

00000000802010d8 <.Lpcrel_hi1>:
    802010d8:	0001a597          	auipc	a1,0x1a
    802010dc:	f2858593          	add	a1,a1,-216 # 8021b000 <_ZN11hello_world9hyp_alloc14heap_allocator10HEAP_SPACE17h16e95a0fea74a537E>
    802010e0:	fab43423          	sd	a1,-88(s0)
    802010e4:	00300637          	lui	a2,0x300
    802010e8:	fac43823          	sd	a2,-80(s0)
    802010ec:	00004097          	auipc	ra,0x4
    802010f0:	884080e7          	jalr	-1916(ra) # 80204970 <_ZN22buddy_system_allocator4Heap4init17h9eb587a9e0e7981eE>
    802010f4:	f7843503          	ld	a0,-136(s0)
    802010f8:	00004097          	auipc	ra,0x4
    802010fc:	a62080e7          	jalr	-1438(ra) # 80204b5a <_ZN4core3ptr80drop_in_place$LT$spin..mutex..MutexGuard$LT$buddy_system_allocator..Heap$GT$$GT$17hfaa414ee47c0699cE>
    80201100:	60aa                	ld	ra,136(sp)
    80201102:	640a                	ld	s0,128(sp)
    80201104:	6149                	add	sp,sp,144
    80201106:	8082                	ret

0000000080201108 <_ZN5riscv8register4sepc4read17had64edd427345954E>:
    80201108:	1141                	add	sp,sp,-16
    8020110a:	e406                	sd	ra,8(sp)
    8020110c:	e022                	sd	s0,0(sp)
    8020110e:	0800                	add	s0,sp,16
    80201110:	00000097          	auipc	ra,0x0
    80201114:	010080e7          	jalr	16(ra) # 80201120 <_ZN5riscv8register4sepc5_read17hbdef0dafb2c69496E>
    80201118:	60a2                	ld	ra,8(sp)
    8020111a:	6402                	ld	s0,0(sp)
    8020111c:	0141                	add	sp,sp,16
    8020111e:	8082                	ret

0000000080201120 <_ZN5riscv8register4sepc5_read17hbdef0dafb2c69496E>:
    80201120:	1101                	add	sp,sp,-32
    80201122:	ec06                	sd	ra,24(sp)
    80201124:	e822                	sd	s0,16(sp)
    80201126:	1000                	add	s0,sp,32
    80201128:	14102573          	csrr	a0,sepc
    8020112c:	fea43423          	sd	a0,-24(s0)
    80201130:	fe843503          	ld	a0,-24(s0)
    80201134:	60e2                	ld	ra,24(sp)
    80201136:	6442                	ld	s0,16(sp)
    80201138:	6105                	add	sp,sp,32
    8020113a:	8082                	ret

000000008020113c <_ZN90_$LT$hypercraft..arch..regs..GeneralPurposeRegisters$u20$as$u20$core..default..Default$GT$7default17h3fb5b412bc55897aE>:
    8020113c:	712d                	add	sp,sp,-288
    8020113e:	ee06                	sd	ra,280(sp)
    80201140:	ea22                	sd	s0,272(sp)
    80201142:	1200                	add	s0,sp,288
    80201144:	eea43023          	sd	a0,-288(s0)
    80201148:	ef040513          	add	a0,s0,-272
    8020114c:	eea43423          	sd	a0,-280(s0)
    80201150:	00002097          	auipc	ra,0x2
    80201154:	d84080e7          	jalr	-636(ra) # 80202ed4 <_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17hcd0dc45849769110E>
    80201158:	ee043503          	ld	a0,-288(s0)
    8020115c:	ee843583          	ld	a1,-280(s0)
    80201160:	10000613          	li	a2,256
    80201164:	00005097          	auipc	ra,0x5
    80201168:	700080e7          	jalr	1792(ra) # 80206864 <memcpy>
    8020116c:	60f2                	ld	ra,280(sp)
    8020116e:	6452                	ld	s0,272(sp)
    80201170:	6115                	add	sp,sp,288
    80201172:	8082                	ret

0000000080201174 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE>:
    80201174:	715d                	add	sp,sp,-80
    80201176:	e486                	sd	ra,72(sp)
    80201178:	e0a2                	sd	s0,64(sp)
    8020117a:	0880                	add	s0,sp,80
    8020117c:	faa43c23          	sd	a0,-72(s0)
    80201180:	fca43c23          	sd	a0,-40(s0)
    80201184:	4581                	li	a1,0
    80201186:	fcb40ba3          	sb	a1,-41(s0)
    8020118a:	4585                	li	a1,1
    8020118c:	fcb40ba3          	sb	a1,-41(s0)
    80201190:	00000097          	auipc	ra,0x0
    80201194:	30e080e7          	jalr	782(ra) # 8020149e <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E>
    80201198:	fca43423          	sd	a0,-56(s0)
    8020119c:	fc843503          	ld	a0,-56(s0)
    802011a0:	c909                	beqz	a0,802011b2 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x3e>
    802011a2:	a009                	j	802011a4 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x30>
    802011a4:	fc843503          	ld	a0,-56(s0)
    802011a8:	fea43423          	sd	a0,-24(s0)
    802011ac:	fca43023          	sd	a0,-64(s0)
    802011b0:	a829                	j	802011ca <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x56>
    802011b2:	fb843503          	ld	a0,-72(s0)
    802011b6:	4581                	li	a1,0
    802011b8:	fcb40ba3          	sb	a1,-41(s0)
    802011bc:	00000097          	auipc	ra,0x0
    802011c0:	026080e7          	jalr	38(ra) # 802011e2 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E>
    802011c4:	fca43023          	sd	a0,-64(s0)
    802011c8:	a009                	j	802011ca <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x56>
    802011ca:	fd744503          	lbu	a0,-41(s0)
    802011ce:	8905                	and	a0,a0,1
    802011d0:	e901                	bnez	a0,802011e0 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x6c>
    802011d2:	a009                	j	802011d4 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x60>
    802011d4:	fc043503          	ld	a0,-64(s0)
    802011d8:	60a6                	ld	ra,72(sp)
    802011da:	6406                	ld	s0,64(sp)
    802011dc:	6161                	add	sp,sp,80
    802011de:	8082                	ret
    802011e0:	bfd5                	j	802011d4 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE+0x60>

00000000802011e2 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E>:
    802011e2:	7149                	add	sp,sp,-368
    802011e4:	f686                	sd	ra,360(sp)
    802011e6:	f2a2                	sd	s0,352(sp)
    802011e8:	1a80                	add	s0,sp,368
    802011ea:	eaa43423          	sd	a0,-344(s0)
    802011ee:	f2a43c23          	sd	a0,-200(s0)
    802011f2:	4501                	li	a0,0
    802011f4:	f2a40ba3          	sb	a0,-201(s0)
    802011f8:	4505                	li	a0,1
    802011fa:	f2a40ba3          	sb	a0,-201(s0)
    802011fe:	a009                	j	80201200 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x1e>
    80201200:	ea843503          	ld	a0,-344(s0)
    80201204:	03050513          	add	a0,a0,48
    80201208:	4581                	li	a1,0
    8020120a:	fab40723          	sb	a1,-82(s0)
    8020120e:	4585                	li	a1,1
    80201210:	fab407a3          	sb	a1,-81(s0)
    80201214:	fca43023          	sd	a0,-64(s0)
    80201218:	4709                	li	a4,2
    8020121a:	fce405a3          	sb	a4,-53(s0)
    8020121e:	fce40623          	sb	a4,-52(s0)
    80201222:	faf40603          	lb	a2,-81(s0)
    80201226:	fae40583          	lb	a1,-82(s0)
    8020122a:	86ba                	mv	a3,a4
    8020122c:	00002097          	auipc	ra,0x2
    80201230:	5bc080e7          	jalr	1468(ra) # 802037e8 <_ZN4core4sync6atomic8AtomicU816compare_exchange17h8a05f20fb369baa7E>
    80201234:	fab40ca3          	sb	a1,-71(s0)
    80201238:	faa40c23          	sb	a0,-72(s0)
    8020123c:	fb844503          	lbu	a0,-72(s0)
    80201240:	8905                	and	a0,a0,1
    80201242:	e115                	bnez	a0,80201266 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x84>
    80201244:	a009                	j	80201246 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x64>
    80201246:	fb940503          	lb	a0,-71(s0)
    8020124a:	fca40723          	sb	a0,-50(s0)
    8020124e:	00004097          	auipc	ra,0x4
    80201252:	b94080e7          	jalr	-1132(ra) # 80204de2 <_ZN4spin4once6status6Status13new_unchecked17hf2ea35bf08e2abdfE>
    80201256:	0ff57513          	zext.b	a0,a0
    8020125a:	faa408a3          	sb	a0,-79(s0)
    8020125e:	4501                	li	a0,0
    80201260:	faa40823          	sb	a0,-80(s0)
    80201264:	a00d                	j	80201286 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0xa4>
    80201266:	fb940503          	lb	a0,-71(s0)
    8020126a:	fca406a3          	sb	a0,-51(s0)
    8020126e:	00004097          	auipc	ra,0x4
    80201272:	b74080e7          	jalr	-1164(ra) # 80204de2 <_ZN4spin4once6status6Status13new_unchecked17hf2ea35bf08e2abdfE>
    80201276:	0ff57513          	zext.b	a0,a0
    8020127a:	faa408a3          	sb	a0,-79(s0)
    8020127e:	4505                	li	a0,1
    80201280:	faa40823          	sb	a0,-80(s0)
    80201284:	a009                	j	80201286 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0xa4>
    80201286:	fb040503          	lb	a0,-80(s0)
    8020128a:	fb140583          	lb	a1,-79(s0)
    8020128e:	eab40ca3          	sb	a1,-327(s0)
    80201292:	eaa40c23          	sb	a0,-328(s0)
    80201296:	eb844503          	lbu	a0,-328(s0)
    8020129a:	8905                	and	a0,a0,1
    8020129c:	e905                	bnez	a0,802012cc <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0xea>
    8020129e:	a009                	j	802012a0 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0xbe>
    802012a0:	ea843503          	ld	a0,-344(s0)
    802012a4:	eb940583          	lb	a1,-327(s0)
    802012a8:	f4b40fa3          	sb	a1,-161(s0)
    802012ac:	03050513          	add	a0,a0,48
    802012b0:	eca43423          	sd	a0,-312(s0)
    802012b4:	4501                	li	a0,0
    802012b6:	f2a40ba3          	sb	a0,-201(s0)
    802012ba:	ed040513          	add	a0,s0,-304
    802012be:	00000097          	auipc	ra,0x0
    802012c2:	330080e7          	jalr	816(ra) # 802015ee <_ZN4spin4once17Once$LT$T$C$R$GT$9call_once28_$u7b$$u7b$closure$u7d$$u7d$17he9e5a382ee84b619E>
    802012c6:	4505                	li	a0,1
    802012c8:	e959                	bnez	a0,8020135e <.Lpcrel_hi1+0x2e>
    802012ca:	a8e1                	j	802013a2 <.Lpcrel_hi1+0x72>
    802012cc:	eb944503          	lbu	a0,-327(s0)
    802012d0:	eaa43023          	sd	a0,-352(s0)
    802012d4:	d515                	beqz	a0,80201200 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x1e>
    802012d6:	a009                	j	802012d8 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0xf6>
    802012d8:	ea043503          	ld	a0,-352(s0)
    802012dc:	0ff57513          	zext.b	a0,a0
    802012e0:	4585                	li	a1,1
    802012e2:	00b50d63          	beq	a0,a1,802012fc <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x11a>
    802012e6:	a009                	j	802012e8 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x106>
    802012e8:	ea043503          	ld	a0,-352(s0)
    802012ec:	0ff57513          	zext.b	a0,a0
    802012f0:	4589                	li	a1,2
    802012f2:	02b50263          	beq	a0,a1,80201316 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x134>
    802012f6:	a009                	j	802012f8 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x116>
    802012f8:	a805                	j	80201328 <.Lpcrel_hi0>
    802012fa:	0000                	unimp
    802012fc:	ea843503          	ld	a0,-344(s0)
    80201300:	00000097          	auipc	ra,0x0
    80201304:	20c080e7          	jalr	524(ra) # 8020150c <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE>
    80201308:	eca43023          	sd	a0,-320(s0)
    8020130c:	ec043503          	ld	a0,-320(s0)
    80201310:	ee0508e3          	beqz	a0,80201200 <_ZN4spin4once17Once$LT$T$C$R$GT$18try_call_once_slow17h2078803186807f84E+0x1e>
    80201314:	a835                	j	80201350 <.Lpcrel_hi1+0x20>
    80201316:	ea843503          	ld	a0,-344(s0)
    8020131a:	00000097          	auipc	ra,0x0
    8020131e:	31c080e7          	jalr	796(ra) # 80201636 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE>
    80201322:	eaa43823          	sd	a0,-336(s0)
    80201326:	a839                	j	80201344 <.Lpcrel_hi1+0x14>

0000000080201328 <.Lpcrel_hi0>:
    80201328:	00006517          	auipc	a0,0x6
    8020132c:	cd850513          	add	a0,a0,-808 # 80207000 <etext>

0000000080201330 <.Lpcrel_hi1>:
    80201330:	00006597          	auipc	a1,0x6
    80201334:	d3858613          	add	a2,a1,-712 # 80207068 <.L__unnamed_2>
    80201338:	45b5                	li	a1,13
    8020133a:	00004097          	auipc	ra,0x4
    8020133e:	220080e7          	jalr	544(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80201342:	0000                	unimp
    80201344:	f3744503          	lbu	a0,-201(s0)
    80201348:	8905                	and	a0,a0,1
    8020134a:	14051963          	bnez	a0,8020149c <.Lpcrel_hi2+0x20>
    8020134e:	a289                	j	80201490 <.Lpcrel_hi2+0x14>
    80201350:	ec043503          	ld	a0,-320(s0)
    80201354:	f4a43823          	sd	a0,-176(s0)
    80201358:	eaa43823          	sd	a0,-336(s0)
    8020135c:	b7e5                	j	80201344 <.Lpcrel_hi1+0x14>
    8020135e:	ea843503          	ld	a0,-344(s0)
    80201362:	ef843583          	ld	a1,-264(s0)
    80201366:	f2b43423          	sd	a1,-216(s0)
    8020136a:	ef043583          	ld	a1,-272(s0)
    8020136e:	f2b43023          	sd	a1,-224(s0)
    80201372:	ee843583          	ld	a1,-280(s0)
    80201376:	f0b43c23          	sd	a1,-232(s0)
    8020137a:	ee043583          	ld	a1,-288(s0)
    8020137e:	f0b43823          	sd	a1,-240(s0)
    80201382:	ed843583          	ld	a1,-296(s0)
    80201386:	f0b43423          	sd	a1,-248(s0)
    8020138a:	ed043583          	ld	a1,-304(s0)
    8020138e:	f0b43023          	sd	a1,-256(s0)
    80201392:	faa43023          	sd	a0,-96(s0)
    80201396:	85aa                	mv	a1,a0
    80201398:	e8b43c23          	sd	a1,-360(s0)
    8020139c:	891d                	and	a0,a0,7
    8020139e:	cd05                	beqz	a0,802013d6 <.Lpcrel_hi1+0xa6>
    802013a0:	a8e1                	j	80201478 <.Lpcrel_hi1+0x148>
    802013a2:	ec843503          	ld	a0,-312(s0)
    802013a6:	00001097          	auipc	ra,0x1
    802013aa:	dde080e7          	jalr	-546(ra) # 80202184 <_ZN4core3mem6forget17h02cc43c52e69d99aE>
    802013ae:	ea843503          	ld	a0,-344(s0)
    802013b2:	03050513          	add	a0,a0,48
    802013b6:	4581                	li	a1,0
    802013b8:	fcb40fa3          	sb	a1,-33(s0)
    802013bc:	fea43023          	sd	a0,-32(s0)
    802013c0:	4605                	li	a2,1
    802013c2:	fec407a3          	sb	a2,-17(s0)
    802013c6:	fdf40583          	lb	a1,-33(s0)
    802013ca:	00002097          	auipc	ra,0x2
    802013ce:	474080e7          	jalr	1140(ra) # 8020383e <_ZN4core4sync6atomic8AtomicU85store17h285e44554cbc7f62E>
    802013d2:	0000                	unimp
    802013d4:	bf85                	j	80201344 <.Lpcrel_hi1+0x14>
    802013d6:	ea843583          	ld	a1,-344(s0)
    802013da:	f6b43023          	sd	a1,-160(s0)
    802013de:	f8b43c23          	sd	a1,-104(s0)
    802013e2:	f2843503          	ld	a0,-216(s0)
    802013e6:	f8a43823          	sd	a0,-112(s0)
    802013ea:	f2043503          	ld	a0,-224(s0)
    802013ee:	f8a43423          	sd	a0,-120(s0)
    802013f2:	f1843503          	ld	a0,-232(s0)
    802013f6:	f8a43023          	sd	a0,-128(s0)
    802013fa:	f1043503          	ld	a0,-240(s0)
    802013fe:	f6a43c23          	sd	a0,-136(s0)
    80201402:	f0843503          	ld	a0,-248(s0)
    80201406:	f6a43823          	sd	a0,-144(s0)
    8020140a:	f0043503          	ld	a0,-256(s0)
    8020140e:	f6a43423          	sd	a0,-152(s0)
    80201412:	f9043503          	ld	a0,-112(s0)
    80201416:	f588                	sd	a0,40(a1)
    80201418:	f8843503          	ld	a0,-120(s0)
    8020141c:	f188                	sd	a0,32(a1)
    8020141e:	f8043503          	ld	a0,-128(s0)
    80201422:	ed88                	sd	a0,24(a1)
    80201424:	f7843503          	ld	a0,-136(s0)
    80201428:	e988                	sd	a0,16(a1)
    8020142a:	f7043503          	ld	a0,-144(s0)
    8020142e:	e588                	sd	a0,8(a1)
    80201430:	f6843503          	ld	a0,-152(s0)
    80201434:	e188                	sd	a0,0(a1)
    80201436:	ec843503          	ld	a0,-312(s0)
    8020143a:	00001097          	auipc	ra,0x1
    8020143e:	d4a080e7          	jalr	-694(ra) # 80202184 <_ZN4core3mem6forget17h02cc43c52e69d99aE>
    80201442:	ea843503          	ld	a0,-344(s0)
    80201446:	03050513          	add	a0,a0,48
    8020144a:	4589                	li	a1,2
    8020144c:	fcb407a3          	sb	a1,-49(s0)
    80201450:	fca43823          	sd	a0,-48(s0)
    80201454:	4605                	li	a2,1
    80201456:	fcc40f23          	sb	a2,-34(s0)
    8020145a:	fcf40583          	lb	a1,-49(s0)
    8020145e:	00002097          	auipc	ra,0x2
    80201462:	3e0080e7          	jalr	992(ra) # 8020383e <_ZN4core4sync6atomic8AtomicU85store17h285e44554cbc7f62E>
    80201466:	ea843503          	ld	a0,-344(s0)
    8020146a:	00000097          	auipc	ra,0x0
    8020146e:	1cc080e7          	jalr	460(ra) # 80201636 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE>
    80201472:	eaa43823          	sd	a0,-336(s0)
    80201476:	b5f9                	j	80201344 <.Lpcrel_hi1+0x14>
    80201478:	e9843583          	ld	a1,-360(s0)

000000008020147c <.Lpcrel_hi2>:
    8020147c:	00006517          	auipc	a0,0x6
    80201480:	c0450613          	add	a2,a0,-1020 # 80207080 <.L__unnamed_3>
    80201484:	4521                	li	a0,8
    80201486:	00004097          	auipc	ra,0x4
    8020148a:	140080e7          	jalr	320(ra) # 802055c6 <_ZN4core9panicking36panic_misaligned_pointer_dereference17h8d2ff04f0586d390E>
    8020148e:	0000                	unimp
    80201490:	eb043503          	ld	a0,-336(s0)
    80201494:	70b6                	ld	ra,360(sp)
    80201496:	7416                	ld	s0,352(sp)
    80201498:	6175                	add	sp,sp,368
    8020149a:	8082                	ret
    8020149c:	bfd5                	j	80201490 <.Lpcrel_hi2+0x14>

000000008020149e <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E>:
    8020149e:	715d                	add	sp,sp,-80
    802014a0:	e486                	sd	ra,72(sp)
    802014a2:	e0a2                	sd	s0,64(sp)
    802014a4:	0880                	add	s0,sp,80
    802014a6:	faa43c23          	sd	a0,-72(s0)
    802014aa:	fca43c23          	sd	a0,-40(s0)
    802014ae:	03050513          	add	a0,a0,48
    802014b2:	fea43023          	sd	a0,-32(s0)
    802014b6:	4589                	li	a1,2
    802014b8:	fcb43023          	sd	a1,-64(s0)
    802014bc:	feb407a3          	sb	a1,-17(s0)
    802014c0:	00002097          	auipc	ra,0x2
    802014c4:	35a080e7          	jalr	858(ra) # 8020381a <_ZN4core4sync6atomic8AtomicU84load17h76a4bc9d7c5a48f0E>
    802014c8:	00004097          	auipc	ra,0x4
    802014cc:	91a080e7          	jalr	-1766(ra) # 80204de2 <_ZN4spin4once6status6Status13new_unchecked17hf2ea35bf08e2abdfE>
    802014d0:	fc043583          	ld	a1,-64(s0)
    802014d4:	0ff57513          	zext.b	a0,a0
    802014d8:	fca40ba3          	sb	a0,-41(s0)
    802014dc:	fd744503          	lbu	a0,-41(s0)
    802014e0:	00b51c63          	bne	a0,a1,802014f8 <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E+0x5a>
    802014e4:	a009                	j	802014e6 <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E+0x48>
    802014e6:	fb843503          	ld	a0,-72(s0)
    802014ea:	00000097          	auipc	ra,0x0
    802014ee:	14c080e7          	jalr	332(ra) # 80201636 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE>
    802014f2:	fca43423          	sd	a0,-56(s0)
    802014f6:	a029                	j	80201500 <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E+0x62>
    802014f8:	4501                	li	a0,0
    802014fa:	fca43423          	sd	a0,-56(s0)
    802014fe:	a009                	j	80201500 <_ZN4spin4once17Once$LT$T$C$R$GT$3get17h1a3a9eaa7da12e13E+0x62>
    80201500:	fc843503          	ld	a0,-56(s0)
    80201504:	60a6                	ld	ra,72(sp)
    80201506:	6406                	ld	s0,64(sp)
    80201508:	6161                	add	sp,sp,80
    8020150a:	8082                	ret

000000008020150c <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE>:
    8020150c:	715d                	add	sp,sp,-80
    8020150e:	e486                	sd	ra,72(sp)
    80201510:	e0a2                	sd	s0,64(sp)
    80201512:	0880                	add	s0,sp,80
    80201514:	fca43023          	sd	a0,-64(s0)
    80201518:	fca43c23          	sd	a0,-40(s0)
    8020151c:	a009                	j	8020151e <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x12>
    8020151e:	fc043503          	ld	a0,-64(s0)
    80201522:	03050513          	add	a0,a0,48
    80201526:	fea43023          	sd	a0,-32(s0)
    8020152a:	4589                	li	a1,2
    8020152c:	feb407a3          	sb	a1,-17(s0)
    80201530:	00002097          	auipc	ra,0x2
    80201534:	2ea080e7          	jalr	746(ra) # 8020381a <_ZN4core4sync6atomic8AtomicU84load17h76a4bc9d7c5a48f0E>
    80201538:	00004097          	auipc	ra,0x4
    8020153c:	8aa080e7          	jalr	-1878(ra) # 80204de2 <_ZN4spin4once6status6Status13new_unchecked17hf2ea35bf08e2abdfE>
    80201540:	0ff57513          	zext.b	a0,a0
    80201544:	fca40ba3          	sb	a0,-41(s0)
    80201548:	fd744503          	lbu	a0,-41(s0)
    8020154c:	faa43c23          	sd	a0,-72(s0)
    80201550:	c505                	beqz	a0,80201578 <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x6c>
    80201552:	a009                	j	80201554 <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x48>
    80201554:	fb843503          	ld	a0,-72(s0)
    80201558:	0ff57513          	zext.b	a0,a0
    8020155c:	4585                	li	a1,1
    8020155e:	02b50163          	beq	a0,a1,80201580 <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x74>
    80201562:	a009                	j	80201564 <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x58>
    80201564:	fb843503          	ld	a0,-72(s0)
    80201568:	0ff57513          	zext.b	a0,a0
    8020156c:	4589                	li	a1,2
    8020156e:	00b50e63          	beq	a0,a1,8020158a <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x7e>
    80201572:	a009                	j	80201574 <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x68>
    80201574:	a025                	j	8020159c <.Lpcrel_hi3>
    80201576:	0000                	unimp
    80201578:	4501                	li	a0,0
    8020157a:	fca43423          	sd	a0,-56(s0)
    8020157e:	a835                	j	802015ba <.Lpcrel_hi4+0x16>
    80201580:	00002097          	auipc	ra,0x2
    80201584:	254080e7          	jalr	596(ra) # 802037d4 <_ZN4core4sync6atomic14spin_loop_hint17h39eb60b027d73982E>
    80201588:	bf59                	j	8020151e <_ZN4spin4once17Once$LT$T$C$R$GT$4poll17hac29d6913a0f3a5bE+0x12>
    8020158a:	fc043503          	ld	a0,-64(s0)
    8020158e:	00000097          	auipc	ra,0x0
    80201592:	0a8080e7          	jalr	168(ra) # 80201636 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE>
    80201596:	fca43423          	sd	a0,-56(s0)
    8020159a:	a005                	j	802015ba <.Lpcrel_hi4+0x16>

000000008020159c <.Lpcrel_hi3>:
    8020159c:	00006517          	auipc	a0,0x6
    802015a0:	afc50513          	add	a0,a0,-1284 # 80207098 <.L__unnamed_4>

00000000802015a4 <.Lpcrel_hi4>:
    802015a4:	00006597          	auipc	a1,0x6
    802015a8:	b1c58613          	add	a2,a1,-1252 # 802070c0 <.L__unnamed_5>
    802015ac:	02600593          	li	a1,38
    802015b0:	00004097          	auipc	ra,0x4
    802015b4:	faa080e7          	jalr	-86(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802015b8:	0000                	unimp
    802015ba:	fc843503          	ld	a0,-56(s0)
    802015be:	60a6                	ld	ra,72(sp)
    802015c0:	6406                	ld	s0,64(sp)
    802015c2:	6161                	add	sp,sp,80
    802015c4:	8082                	ret

00000000802015c6 <_ZN4spin4once17Once$LT$T$C$R$GT$9call_once17ha5d1ffe69909146dE>:
    802015c6:	7139                	add	sp,sp,-64
    802015c8:	fc06                	sd	ra,56(sp)
    802015ca:	f822                	sd	s0,48(sp)
    802015cc:	0080                	add	s0,sp,64
    802015ce:	fca43c23          	sd	a0,-40(s0)
    802015d2:	00000097          	auipc	ra,0x0
    802015d6:	ba2080e7          	jalr	-1118(ra) # 80201174 <_ZN4spin4once17Once$LT$T$C$R$GT$13try_call_once17h676928ac01136eedE>
    802015da:	fca43823          	sd	a0,-48(s0)
    802015de:	fd043503          	ld	a0,-48(s0)
    802015e2:	fea43423          	sd	a0,-24(s0)
    802015e6:	70e2                	ld	ra,56(sp)
    802015e8:	7442                	ld	s0,48(sp)
    802015ea:	6121                	add	sp,sp,64
    802015ec:	8082                	ret

00000000802015ee <_ZN4spin4once17Once$LT$T$C$R$GT$9call_once28_$u7b$$u7b$closure$u7d$$u7d$17he9e5a382ee84b619E>:
    802015ee:	715d                	add	sp,sp,-80
    802015f0:	e486                	sd	ra,72(sp)
    802015f2:	e0a2                	sd	s0,64(sp)
    802015f4:	0880                	add	s0,sp,80
    802015f6:	faa43823          	sd	a0,-80(s0)
    802015fa:	fb840513          	add	a0,s0,-72
    802015fe:	00002097          	auipc	ra,0x2
    80201602:	60c080e7          	jalr	1548(ra) # 80203c0a <_ZN11hello_world9hyp_alloc15frame_allocator20init_frame_allocator28_$u7b$$u7b$closure$u7d$$u7d$17h5c827a3b806607ceE>
    80201606:	fb043583          	ld	a1,-80(s0)
    8020160a:	fe043503          	ld	a0,-32(s0)
    8020160e:	f588                	sd	a0,40(a1)
    80201610:	fd843503          	ld	a0,-40(s0)
    80201614:	f188                	sd	a0,32(a1)
    80201616:	fd043503          	ld	a0,-48(s0)
    8020161a:	ed88                	sd	a0,24(a1)
    8020161c:	fc843503          	ld	a0,-56(s0)
    80201620:	e988                	sd	a0,16(a1)
    80201622:	fc043503          	ld	a0,-64(s0)
    80201626:	e588                	sd	a0,8(a1)
    80201628:	fb843503          	ld	a0,-72(s0)
    8020162c:	e188                	sd	a0,0(a1)
    8020162e:	60a6                	ld	ra,72(sp)
    80201630:	6406                	ld	s0,64(sp)
    80201632:	6161                	add	sp,sp,80
    80201634:	8082                	ret

0000000080201636 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE>:
    80201636:	7139                	add	sp,sp,-64
    80201638:	fc06                	sd	ra,56(sp)
    8020163a:	f822                	sd	s0,48(sp)
    8020163c:	0080                	add	s0,sp,64
    8020163e:	fca43423          	sd	a0,-56(s0)
    80201642:	fca43c23          	sd	a0,-40(s0)
    80201646:	fea43423          	sd	a0,-24(s0)
    8020164a:	85aa                	mv	a1,a0
    8020164c:	fcb43823          	sd	a1,-48(s0)
    80201650:	891d                	and	a0,a0,7
    80201652:	ed01                	bnez	a0,8020166a <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE+0x34>
    80201654:	a009                	j	80201656 <_ZN4spin4once17Once$LT$T$C$R$GT$9force_get17h40e4915b585b6f6fE+0x20>
    80201656:	fc843503          	ld	a0,-56(s0)
    8020165a:	fea43023          	sd	a0,-32(s0)
    8020165e:	85aa                	mv	a1,a0
    80201660:	fcb43023          	sd	a1,-64(s0)
    80201664:	891d                	and	a0,a0,7
    80201666:	cd11                	beqz	a0,80201682 <.Lpcrel_hi5+0x14>
    80201668:	a01d                	j	8020168e <.Lpcrel_hi5+0x20>
    8020166a:	fd043583          	ld	a1,-48(s0)

000000008020166e <.Lpcrel_hi5>:
    8020166e:	00006517          	auipc	a0,0x6
    80201672:	a6a50613          	add	a2,a0,-1430 # 802070d8 <.L__unnamed_6>
    80201676:	4521                	li	a0,8
    80201678:	00004097          	auipc	ra,0x4
    8020167c:	f4e080e7          	jalr	-178(ra) # 802055c6 <_ZN4core9panicking36panic_misaligned_pointer_dereference17h8d2ff04f0586d390E>
    80201680:	0000                	unimp
    80201682:	fc843503          	ld	a0,-56(s0)
    80201686:	70e2                	ld	ra,56(sp)
    80201688:	7442                	ld	s0,48(sp)
    8020168a:	6121                	add	sp,sp,64
    8020168c:	8082                	ret
    8020168e:	fc043583          	ld	a1,-64(s0)

0000000080201692 <.Lpcrel_hi6>:
    80201692:	00006517          	auipc	a0,0x6
    80201696:	a5e50613          	add	a2,a0,-1442 # 802070f0 <.L__unnamed_7>
    8020169a:	4521                	li	a0,8
    8020169c:	00004097          	auipc	ra,0x4
    802016a0:	f2a080e7          	jalr	-214(ra) # 802055c6 <_ZN4core9panicking36panic_misaligned_pointer_dereference17h8d2ff04f0586d390E>
	...

00000000802016a6 <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E>:
    802016a6:	7179                	add	sp,sp,-48
    802016a8:	f406                	sd	ra,40(sp)
    802016aa:	f022                	sd	s0,32(sp)
    802016ac:	1800                	add	s0,sp,48
    802016ae:	fca42823          	sw	a0,-48(s0)
    802016b2:	fcb42a23          	sw	a1,-44(s0)
    802016b6:	4505                	li	a0,1
    802016b8:	fea403a3          	sb	a0,-25(s0)
    802016bc:	fd042503          	lw	a0,-48(s0)
    802016c0:	e519                	bnez	a0,802016ce <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x28>
    802016c2:	a009                	j	802016c4 <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x1e>
    802016c4:	00110537          	lui	a0,0x110
    802016c8:	fca42e23          	sw	a0,-36(s0)
    802016cc:	a025                	j	802016f4 <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x4e>
    802016ce:	fd442503          	lw	a0,-44(s0)
    802016d2:	fea42623          	sw	a0,-20(s0)
    802016d6:	4581                	li	a1,0
    802016d8:	feb403a3          	sb	a1,-25(s0)
    802016dc:	fea42023          	sw	a0,-32(s0)
    802016e0:	fe042503          	lw	a0,-32(s0)
    802016e4:	00000097          	auipc	ra,0x0
    802016e8:	934080e7          	jalr	-1740(ra) # 80201018 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next28_$u7b$$u7b$closure$u7d$$u7d$17hc6867185ddbe41b4E>
    802016ec:	997d                	and	a0,a0,-1
    802016ee:	fca42e23          	sw	a0,-36(s0)
    802016f2:	a009                	j	802016f4 <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x4e>
    802016f4:	fe744503          	lbu	a0,-25(s0)
    802016f8:	8905                	and	a0,a0,1
    802016fa:	e901                	bnez	a0,8020170a <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x64>
    802016fc:	a009                	j	802016fe <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x58>
    802016fe:	fdc42503          	lw	a0,-36(s0)
    80201702:	70a2                	ld	ra,40(sp)
    80201704:	7402                	ld	s0,32(sp)
    80201706:	6145                	add	sp,sp,48
    80201708:	8082                	ret
    8020170a:	bfd5                	j	802016fe <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E+0x58>

000000008020170c <_ZN4core6option15Option$LT$T$GT$6unwrap17h33e2ac82c9c2bc3aE>:
    8020170c:	7179                	add	sp,sp,-48
    8020170e:	f406                	sd	ra,40(sp)
    80201710:	f022                	sd	s0,32(sp)
    80201712:	1800                	add	s0,sp,48
    80201714:	fcc43c23          	sd	a2,-40(s0)
    80201718:	fea40023          	sb	a0,-32(s0)
    8020171c:	feb400a3          	sb	a1,-31(s0)
    80201720:	fe044503          	lbu	a0,-32(s0)
    80201724:	4589                	li	a1,2
    80201726:	02b51063          	bne	a0,a1,80201746 <.Lpcrel_hi0+0x16>
    8020172a:	a009                	j	8020172c <_ZN4core6option15Option$LT$T$GT$6unwrap17h33e2ac82c9c2bc3aE+0x20>
    8020172c:	fd843603          	ld	a2,-40(s0)

0000000080201730 <.Lpcrel_hi0>:
    80201730:	00006517          	auipc	a0,0x6
    80201734:	9d850513          	add	a0,a0,-1576 # 80207108 <.L__unnamed_1>
    80201738:	02b00593          	li	a1,43
    8020173c:	00004097          	auipc	ra,0x4
    80201740:	e1e080e7          	jalr	-482(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80201744:	0000                	unimp
    80201746:	fe044503          	lbu	a0,-32(s0)
    8020174a:	fe140583          	lb	a1,-31(s0)
    8020174e:	fea40423          	sb	a0,-24(s0)
    80201752:	feb404a3          	sb	a1,-23(s0)
    80201756:	70a2                	ld	ra,40(sp)
    80201758:	7402                	ld	s0,32(sp)
    8020175a:	6145                	add	sp,sp,48
    8020175c:	8082                	ret

000000008020175e <_ZN4core6option15Option$LT$T$GT$6unwrap17h411eb76940af9212E>:
    8020175e:	7179                	add	sp,sp,-48
    80201760:	f406                	sd	ra,40(sp)
    80201762:	f022                	sd	s0,32(sp)
    80201764:	1800                	add	s0,sp,48
    80201766:	fcb43c23          	sd	a1,-40(s0)
    8020176a:	fea43023          	sd	a0,-32(s0)
    8020176e:	fe043503          	ld	a0,-32(s0)
    80201772:	ed19                	bnez	a0,80201790 <.Lpcrel_hi1+0x16>
    80201774:	a009                	j	80201776 <_ZN4core6option15Option$LT$T$GT$6unwrap17h411eb76940af9212E+0x18>
    80201776:	fd843603          	ld	a2,-40(s0)

000000008020177a <.Lpcrel_hi1>:
    8020177a:	00006517          	auipc	a0,0x6
    8020177e:	98e50513          	add	a0,a0,-1650 # 80207108 <.L__unnamed_1>
    80201782:	02b00593          	li	a1,43
    80201786:	00004097          	auipc	ra,0x4
    8020178a:	dd4080e7          	jalr	-556(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    8020178e:	0000                	unimp
    80201790:	fe043503          	ld	a0,-32(s0)
    80201794:	fea43423          	sd	a0,-24(s0)
    80201798:	70a2                	ld	ra,40(sp)
    8020179a:	7402                	ld	s0,32(sp)
    8020179c:	6145                	add	sp,sp,48
    8020179e:	8082                	ret

00000000802017a0 <_ZN102_$LT$hello_world..hyp_alloc..frame_allocator..PhysAddr$u20$as$u20$core..convert..From$LT$usize$GT$$GT$4from17h10d239523ad20ffeE>:
    802017a0:	1101                	add	sp,sp,-32
    802017a2:	ec06                	sd	ra,24(sp)
    802017a4:	e822                	sd	s0,16(sp)
    802017a6:	1000                	add	s0,sp,32
    802017a8:	fea43423          	sd	a0,-24(s0)
    802017ac:	0522                	sll	a0,a0,0x8
    802017ae:	8121                	srl	a0,a0,0x8
    802017b0:	fea43023          	sd	a0,-32(s0)
    802017b4:	fe043503          	ld	a0,-32(s0)
    802017b8:	60e2                	ld	ra,24(sp)
    802017ba:	6442                	ld	s0,16(sp)
    802017bc:	6105                	add	sp,sp,32
    802017be:	8082                	ret

00000000802017c0 <_ZN11hello_world9hyp_alloc15frame_allocator8PhysAddr5floor17hf7c65c16de669814E>:
    802017c0:	1101                	add	sp,sp,-32
    802017c2:	ec06                	sd	ra,24(sp)
    802017c4:	e822                	sd	s0,16(sp)
    802017c6:	1000                	add	s0,sp,32
    802017c8:	fea43423          	sd	a0,-24(s0)
    802017cc:	6108                	ld	a0,0(a0)
    802017ce:	8131                	srl	a0,a0,0xc
    802017d0:	fea43023          	sd	a0,-32(s0)
    802017d4:	fe043503          	ld	a0,-32(s0)
    802017d8:	60e2                	ld	ra,24(sp)
    802017da:	6442                	ld	s0,16(sp)
    802017dc:	6105                	add	sp,sp,32
    802017de:	8082                	ret

00000000802017e0 <_ZN11hello_world9hyp_alloc15frame_allocator8PhysAddr4ceil17h0ea9f8b6732fc818E>:
    802017e0:	7179                	add	sp,sp,-48
    802017e2:	f406                	sd	ra,40(sp)
    802017e4:	f022                	sd	s0,32(sp)
    802017e6:	1800                	add	s0,sp,48
    802017e8:	fea43423          	sd	a0,-24(s0)
    802017ec:	6108                	ld	a0,0(a0)
    802017ee:	fff50593          	add	a1,a0,-1
    802017f2:	fcb43c23          	sd	a1,-40(s0)
    802017f6:	c919                	beqz	a0,8020180c <.Lpcrel_hi0>
    802017f8:	a009                	j	802017fa <_ZN11hello_world9hyp_alloc15frame_allocator8PhysAddr4ceil17h0ea9f8b6732fc818E+0x1a>
    802017fa:	fd843583          	ld	a1,-40(s0)
    802017fe:	6505                	lui	a0,0x1
    80201800:	952e                	add	a0,a0,a1
    80201802:	fca43823          	sd	a0,-48(s0)
    80201806:	02b56d63          	bltu	a0,a1,80201840 <.Lpcrel_hi2>
    8020180a:	a005                	j	8020182a <.Lpcrel_hi1+0x16>

000000008020180c <.Lpcrel_hi0>:
    8020180c:	00006517          	auipc	a0,0x6
    80201810:	97450513          	add	a0,a0,-1676 # 80207180 <str.0>

0000000080201814 <.Lpcrel_hi1>:
    80201814:	00006597          	auipc	a1,0x6
    80201818:	95458613          	add	a2,a1,-1708 # 80207168 <.L__unnamed_1>
    8020181c:	02100593          	li	a1,33
    80201820:	00004097          	auipc	ra,0x4
    80201824:	d3a080e7          	jalr	-710(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80201828:	0000                	unimp
    8020182a:	fd043503          	ld	a0,-48(s0)
    8020182e:	8131                	srl	a0,a0,0xc
    80201830:	fea43023          	sd	a0,-32(s0)
    80201834:	fe043503          	ld	a0,-32(s0)
    80201838:	70a2                	ld	ra,40(sp)
    8020183a:	7402                	ld	s0,32(sp)
    8020183c:	6145                	add	sp,sp,48
    8020183e:	8082                	ret

0000000080201840 <.Lpcrel_hi2>:
    80201840:	00006517          	auipc	a0,0x6
    80201844:	98050513          	add	a0,a0,-1664 # 802071c0 <str.1>

0000000080201848 <.Lpcrel_hi3>:
    80201848:	00006597          	auipc	a1,0x6
    8020184c:	96058613          	add	a2,a1,-1696 # 802071a8 <.L__unnamed_2>
    80201850:	45f1                	li	a1,28
    80201852:	00004097          	auipc	ra,0x4
    80201856:	d08080e7          	jalr	-760(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

000000008020185c <_ZN11hello_world9hyp_alloc15frame_allocator19StackFrameAllocator4init17hdf2368df4d84172dE>:
    8020185c:	7179                	add	sp,sp,-48
    8020185e:	f406                	sd	ra,40(sp)
    80201860:	f022                	sd	s0,32(sp)
    80201862:	1800                	add	s0,sp,48
    80201864:	fca43c23          	sd	a0,-40(s0)
    80201868:	feb43023          	sd	a1,-32(s0)
    8020186c:	fec43423          	sd	a2,-24(s0)
    80201870:	e10c                	sd	a1,0(a0)
    80201872:	e510                	sd	a2,8(a0)
    80201874:	70a2                	ld	ra,40(sp)
    80201876:	7402                	ld	s0,32(sp)
    80201878:	6145                	add	sp,sp,48
    8020187a:	8082                	ret

000000008020187c <_ZN136_$LT$hello_world..hyp_alloc..frame_allocator..StackFrameAllocator$u20$as$u20$hello_world..hyp_alloc..frame_allocator..FrameAllocator$GT$3new17hfc05673ada866e4bE>:
    8020187c:	7179                	add	sp,sp,-48
    8020187e:	f406                	sd	ra,40(sp)
    80201880:	f022                	sd	s0,32(sp)
    80201882:	1800                	add	s0,sp,48
    80201884:	fca43823          	sd	a0,-48(s0)
    80201888:	fd840513          	add	a0,s0,-40
    8020188c:	00001097          	auipc	ra,0x1
    80201890:	90c080e7          	jalr	-1780(ra) # 80202198 <_ZN5alloc3vec12Vec$LT$T$GT$3new17h4439be25237b218cE>
    80201894:	fd043583          	ld	a1,-48(s0)
    80201898:	4501                	li	a0,0
    8020189a:	e188                	sd	a0,0(a1)
    8020189c:	e588                	sd	a0,8(a1)
    8020189e:	fe843503          	ld	a0,-24(s0)
    802018a2:	f188                	sd	a0,32(a1)
    802018a4:	fe043503          	ld	a0,-32(s0)
    802018a8:	ed88                	sd	a0,24(a1)
    802018aa:	fd843503          	ld	a0,-40(s0)
    802018ae:	e988                	sd	a0,16(a1)
    802018b0:	70a2                	ld	ra,40(sp)
    802018b2:	7402                	ld	s0,32(sp)
    802018b4:	6145                	add	sp,sp,48
    802018b6:	8082                	ret

00000000802018b8 <_ZN11hello_world9hyp_alloc15frame_allocator20init_frame_allocator17h734b165da2386cfeE>:
    802018b8:	1141                	add	sp,sp,-16
    802018ba:	e406                	sd	ra,8(sp)
    802018bc:	e022                	sd	s0,0(sp)
    802018be:	0800                	add	s0,sp,16

00000000802018c0 <.Lpcrel_hi4>:
    802018c0:	0031a517          	auipc	a0,0x31a
    802018c4:	86850513          	add	a0,a0,-1944 # 8051b128 <_ZN11hello_world9hyp_alloc15frame_allocator15FRAME_ALLOCATOR17he14daf7ef11ceb11E>
    802018c8:	00000097          	auipc	ra,0x0
    802018cc:	cfe080e7          	jalr	-770(ra) # 802015c6 <_ZN4spin4once17Once$LT$T$C$R$GT$9call_once17ha5d1ffe69909146dE>
    802018d0:	60a2                	ld	ra,8(sp)
    802018d2:	6402                	ld	s0,0(sp)
    802018d4:	0141                	add	sp,sp,16
    802018d6:	8082                	ret

00000000802018d8 <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17hdd2b385b55eca399E>:
    802018d8:	7139                	add	sp,sp,-64
    802018da:	fc06                	sd	ra,56(sp)
    802018dc:	f822                	sd	s0,48(sp)
    802018de:	0080                	add	s0,sp,64
    802018e0:	fca43823          	sd	a0,-48(s0)
    802018e4:	fcb43c23          	sd	a1,-40(s0)
    802018e8:	fea43023          	sd	a0,-32(s0)
    802018ec:	feb43423          	sd	a1,-24(s0)
    802018f0:	00001097          	auipc	ra,0x1
    802018f4:	8ce080e7          	jalr	-1842(ra) # 802021be <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E>
    802018f8:	fca43023          	sd	a0,-64(s0)
    802018fc:	fcb43423          	sd	a1,-56(s0)
    80201900:	fc043503          	ld	a0,-64(s0)
    80201904:	fc843583          	ld	a1,-56(s0)
    80201908:	70e2                	ld	ra,56(sp)
    8020190a:	7442                	ld	s0,48(sp)
    8020190c:	6121                	add	sp,sp,64
    8020190e:	8082                	ret

0000000080201910 <_ZN4core5panic8location8Location4file17hd364c6f0fc66a5a0E>:
    80201910:	1101                	add	sp,sp,-32
    80201912:	ec06                	sd	ra,24(sp)
    80201914:	e822                	sd	s0,16(sp)
    80201916:	1000                	add	s0,sp,32
    80201918:	85aa                	mv	a1,a0
    8020191a:	feb43423          	sd	a1,-24(s0)
    8020191e:	6188                	ld	a0,0(a1)
    80201920:	658c                	ld	a1,8(a1)
    80201922:	60e2                	ld	ra,24(sp)
    80201924:	6442                	ld	s0,16(sp)
    80201926:	6105                	add	sp,sp,32
    80201928:	8082                	ret

000000008020192a <_ZN4core5panic8location8Location4line17h86e5ccef841eb266E>:
    8020192a:	1101                	add	sp,sp,-32
    8020192c:	ec06                	sd	ra,24(sp)
    8020192e:	e822                	sd	s0,16(sp)
    80201930:	1000                	add	s0,sp,32
    80201932:	fea43423          	sd	a0,-24(s0)
    80201936:	4908                	lw	a0,16(a0)
    80201938:	60e2                	ld	ra,24(sp)
    8020193a:	6442                	ld	s0,16(sp)
    8020193c:	6105                	add	sp,sp,32
    8020193e:	8082                	ret

0000000080201940 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E>:
    80201940:	7155                	add	sp,sp,-208
    80201942:	e586                	sd	ra,200(sp)
    80201944:	e1a2                	sd	s0,192(sp)
    80201946:	0980                	add	s0,sp,208
    80201948:	f2e43823          	sd	a4,-208(s0)
    8020194c:	f2d43c23          	sd	a3,-200(s0)
    80201950:	f4c43023          	sd	a2,-192(s0)
    80201954:	f4b43423          	sd	a1,-184(s0)
    80201958:	f4a43823          	sd	a0,-176(s0)
    8020195c:	f6a43c23          	sd	a0,-136(s0)
    80201960:	f8b43023          	sd	a1,-128(s0)
    80201964:	f8c43423          	sd	a2,-120(s0)
    80201968:	f8d43823          	sd	a3,-112(s0)
    8020196c:	00a5ea63          	bltu	a1,a0,80201980 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E+0x40>
    80201970:	a009                	j	80201972 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E+0x32>
    80201972:	f3843503          	ld	a0,-200(s0)
    80201976:	f4843583          	ld	a1,-184(s0)
    8020197a:	08b56663          	bltu	a0,a1,80201a06 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E+0xc6>
    8020197e:	a821                	j	80201996 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E+0x56>
    80201980:	f3043603          	ld	a2,-208(s0)
    80201984:	f4843583          	ld	a1,-184(s0)
    80201988:	f5043503          	ld	a0,-176(s0)
    8020198c:	00005097          	auipc	ra,0x5
    80201990:	9a6080e7          	jalr	-1626(ra) # 80206332 <_ZN4core5slice5index22slice_index_order_fail17h05d9627a32fe21dbE>
    80201994:	0000                	unimp
    80201996:	f4043583          	ld	a1,-192(s0)
    8020199a:	f5043603          	ld	a2,-176(s0)
    8020199e:	f4843503          	ld	a0,-184(s0)
    802019a2:	f3843683          	ld	a3,-200(s0)
    802019a6:	f8b43c23          	sd	a1,-104(s0)
    802019aa:	fad43023          	sd	a3,-96(s0)
    802019ae:	8d11                	sub	a0,a0,a2
    802019b0:	faa43423          	sd	a0,-88(s0)
    802019b4:	fa843503          	ld	a0,-88(s0)
    802019b8:	faa43823          	sd	a0,-80(s0)
    802019bc:	fab43c23          	sd	a1,-72(s0)
    802019c0:	fcc43023          	sd	a2,-64(s0)
    802019c4:	fcc43423          	sd	a2,-56(s0)
    802019c8:	95b2                	add	a1,a1,a2
    802019ca:	fcb43823          	sd	a1,-48(s0)
    802019ce:	fd043583          	ld	a1,-48(s0)
    802019d2:	fcb43c23          	sd	a1,-40(s0)
    802019d6:	fea43023          	sd	a0,-32(s0)
    802019da:	feb43423          	sd	a1,-24(s0)
    802019de:	f6b43423          	sd	a1,-152(s0)
    802019e2:	f6a43823          	sd	a0,-144(s0)
    802019e6:	f6843583          	ld	a1,-152(s0)
    802019ea:	f7043503          	ld	a0,-144(s0)
    802019ee:	f4b43c23          	sd	a1,-168(s0)
    802019f2:	f6a43023          	sd	a0,-160(s0)
    802019f6:	f5843503          	ld	a0,-168(s0)
    802019fa:	f6043583          	ld	a1,-160(s0)
    802019fe:	60ae                	ld	ra,200(sp)
    80201a00:	640e                	ld	s0,192(sp)
    80201a02:	6169                	add	sp,sp,208
    80201a04:	8082                	ret
    80201a06:	f3043603          	ld	a2,-208(s0)
    80201a0a:	f3843583          	ld	a1,-200(s0)
    80201a0e:	f4843503          	ld	a0,-184(s0)
    80201a12:	00005097          	auipc	ra,0x5
    80201a16:	8d2080e7          	jalr	-1838(ra) # 802062e4 <_ZN4core5slice5index24slice_end_index_len_fail17hebfad67fc831ad67E>
	...

0000000080201a1c <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E>:
    80201a1c:	7115                	add	sp,sp,-224
    80201a1e:	ed86                	sd	ra,216(sp)
    80201a20:	e9a2                	sd	s0,208(sp)
    80201a22:	1180                	add	s0,sp,224
    80201a24:	f4a43423          	sd	a0,-184(s0)
    80201a28:	f8a43c23          	sd	a0,-104(s0)
    80201a2c:	00001097          	auipc	ra,0x1
    80201a30:	8f2080e7          	jalr	-1806(ra) # 8020231e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E>
    80201a34:	f6a43823          	sd	a0,-144(s0)
    80201a38:	f7043503          	ld	a0,-144(s0)
    80201a3c:	e511                	bnez	a0,80201a48 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x2c>
    80201a3e:	a009                	j	80201a40 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x24>
    80201a40:	4501                	li	a0,0
    80201a42:	f6a43423          	sd	a0,-152(s0)
    80201a46:	a801                	j	80201a56 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x3a>
    80201a48:	f7043503          	ld	a0,-144(s0)
    80201a4c:	faa43023          	sd	a0,-96(s0)
    80201a50:	f6a43423          	sd	a0,-152(s0)
    80201a54:	a009                	j	80201a56 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x3a>
    80201a56:	f6843503          	ld	a0,-152(s0)
    80201a5a:	c10d                	beqz	a0,80201a7c <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x60>
    80201a5c:	a009                	j	80201a5e <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x42>
    80201a5e:	f6843503          	ld	a0,-152(s0)
    80201a62:	faa43423          	sd	a0,-88(s0)
    80201a66:	00050503          	lb	a0,0(a0)
    80201a6a:	0ff57593          	zext.b	a1,a0
    80201a6e:	f4b43023          	sd	a1,-192(s0)
    80201a72:	faa409a3          	sb	a0,-77(s0)
    80201a76:	04055263          	bgez	a0,80201aba <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x9e>
    80201a7a:	a829                	j	80201a94 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x78>
    80201a7c:	4501                	li	a0,0
    80201a7e:	f6a42023          	sw	a0,-160(s0)
    80201a82:	a009                	j	80201a84 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x68>
    80201a84:	f6042503          	lw	a0,-160(s0)
    80201a88:	f6442583          	lw	a1,-156(s0)
    80201a8c:	60ee                	ld	ra,216(sp)
    80201a8e:	644e                	ld	s0,208(sp)
    80201a90:	612d                	add	sp,sp,224
    80201a92:	8082                	ret
    80201a94:	f4843503          	ld	a0,-184(s0)
    80201a98:	f4043583          	ld	a1,-192(s0)
    80201a9c:	89fd                	and	a1,a1,31
    80201a9e:	f2b43c23          	sd	a1,-200(s0)
    80201aa2:	fab42a23          	sw	a1,-76(s0)
    80201aa6:	00001097          	auipc	ra,0x1
    80201aaa:	878080e7          	jalr	-1928(ra) # 8020231e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E>
    80201aae:	f6a43c23          	sd	a0,-136(s0)
    80201ab2:	f7843503          	ld	a0,-136(s0)
    80201ab6:	ed01                	bnez	a0,80201ace <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xb2>
    80201ab8:	a0b9                	j	80201b06 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xea>
    80201aba:	f4043503          	ld	a0,-192(s0)
    80201abe:	0ff57513          	zext.b	a0,a0
    80201ac2:	f6a42223          	sw	a0,-156(s0)
    80201ac6:	4505                	li	a0,1
    80201ac8:	f6a42023          	sw	a0,-160(s0)
    80201acc:	bf65                	j	80201a84 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x68>
    80201ace:	f4043503          	ld	a0,-192(s0)
    80201ad2:	f3843583          	ld	a1,-200(s0)
    80201ad6:	f7843603          	ld	a2,-136(s0)
    80201ada:	fac43c23          	sd	a2,-72(s0)
    80201ade:	00064603          	lbu	a2,0(a2) # 300000 <.Lline_table_start0+0x2ba7b7>
    80201ae2:	f2c43823          	sd	a2,-208(s0)
    80201ae6:	fcc403a3          	sb	a2,-57(s0)
    80201aea:	0065959b          	sllw	a1,a1,0x6
    80201aee:	03f67613          	and	a2,a2,63
    80201af2:	8dd1                	or	a1,a1,a2
    80201af4:	f8b42223          	sw	a1,-124(s0)
    80201af8:	0ff57593          	zext.b	a1,a0
    80201afc:	0df00513          	li	a0,223
    80201b00:	00b56c63          	bltu	a0,a1,80201b18 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xfc>
    80201b04:	a011                	j	80201b08 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xec>
    80201b06:	0000                	unimp
    80201b08:	f8442503          	lw	a0,-124(s0)
    80201b0c:	f6a42223          	sw	a0,-156(s0)
    80201b10:	4505                	li	a0,1
    80201b12:	f6a42023          	sw	a0,-160(s0)
    80201b16:	b7bd                	j	80201a84 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x68>
    80201b18:	f4843503          	ld	a0,-184(s0)
    80201b1c:	00001097          	auipc	ra,0x1
    80201b20:	802080e7          	jalr	-2046(ra) # 8020231e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E>
    80201b24:	f8a43423          	sd	a0,-120(s0)
    80201b28:	f8843503          	ld	a0,-120(s0)
    80201b2c:	dd69                	beqz	a0,80201b06 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xea>
    80201b2e:	a009                	j	80201b30 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x114>
    80201b30:	f4043503          	ld	a0,-192(s0)
    80201b34:	f3843583          	ld	a1,-200(s0)
    80201b38:	f3043603          	ld	a2,-208(s0)
    80201b3c:	f8843683          	ld	a3,-120(s0)
    80201b40:	fcd43423          	sd	a3,-56(s0)
    80201b44:	0006c683          	lbu	a3,0(a3)
    80201b48:	fcd40ba3          	sb	a3,-41(s0)
    80201b4c:	03f67613          	and	a2,a2,63
    80201b50:	fcc42c23          	sw	a2,-40(s0)
    80201b54:	061a                	sll	a2,a2,0x6
    80201b56:	03f6f693          	and	a3,a3,63
    80201b5a:	8e55                	or	a2,a2,a3
    80201b5c:	f2c43423          	sd	a2,-216(s0)
    80201b60:	fcc42e23          	sw	a2,-36(s0)
    80201b64:	00c5959b          	sllw	a1,a1,0xc
    80201b68:	8dd1                	or	a1,a1,a2
    80201b6a:	f8b42223          	sw	a1,-124(s0)
    80201b6e:	0ff57593          	zext.b	a1,a0
    80201b72:	0ef00513          	li	a0,239
    80201b76:	00b56463          	bltu	a0,a1,80201b7e <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x162>
    80201b7a:	a009                	j	80201b7c <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x160>
    80201b7c:	b771                	j	80201b08 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xec>
    80201b7e:	f4843503          	ld	a0,-184(s0)
    80201b82:	00000097          	auipc	ra,0x0
    80201b86:	79c080e7          	jalr	1948(ra) # 8020231e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E>
    80201b8a:	f8a43823          	sd	a0,-112(s0)
    80201b8e:	f9043503          	ld	a0,-112(s0)
    80201b92:	d935                	beqz	a0,80201b06 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0xea>
    80201b94:	a009                	j	80201b96 <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x17a>
    80201b96:	f2843583          	ld	a1,-216(s0)
    80201b9a:	f3843503          	ld	a0,-200(s0)
    80201b9e:	f9043603          	ld	a2,-112(s0)
    80201ba2:	fec43023          	sd	a2,-32(s0)
    80201ba6:	00064603          	lbu	a2,0(a2)
    80201baa:	fec407a3          	sb	a2,-17(s0)
    80201bae:	891d                	and	a0,a0,7
    80201bb0:	0125151b          	sllw	a0,a0,0x12
    80201bb4:	0065959b          	sllw	a1,a1,0x6
    80201bb8:	03f67613          	and	a2,a2,63
    80201bbc:	8dd1                	or	a1,a1,a2
    80201bbe:	8d4d                	or	a0,a0,a1
    80201bc0:	f8a42223          	sw	a0,-124(s0)
    80201bc4:	bf65                	j	80201b7c <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E+0x160>

0000000080201bc6 <_ZN5riscv8register6scause4read17hc4ef42e3f7fd8211E>:
    80201bc6:	1101                	add	sp,sp,-32
    80201bc8:	ec06                	sd	ra,24(sp)
    80201bca:	e822                	sd	s0,16(sp)
    80201bcc:	1000                	add	s0,sp,32
    80201bce:	00000097          	auipc	ra,0x0
    80201bd2:	018080e7          	jalr	24(ra) # 80201be6 <_ZN5riscv8register6scause5_read17h2d481abc66b0fe33E>
    80201bd6:	fea43423          	sd	a0,-24(s0)
    80201bda:	fe843503          	ld	a0,-24(s0)
    80201bde:	60e2                	ld	ra,24(sp)
    80201be0:	6442                	ld	s0,16(sp)
    80201be2:	6105                	add	sp,sp,32
    80201be4:	8082                	ret

0000000080201be6 <_ZN5riscv8register6scause5_read17h2d481abc66b0fe33E>:
    80201be6:	1101                	add	sp,sp,-32
    80201be8:	ec06                	sd	ra,24(sp)
    80201bea:	e822                	sd	s0,16(sp)
    80201bec:	1000                	add	s0,sp,32
    80201bee:	14202573          	csrr	a0,scause
    80201bf2:	fea43423          	sd	a0,-24(s0)
    80201bf6:	fe843503          	ld	a0,-24(s0)
    80201bfa:	60e2                	ld	ra,24(sp)
    80201bfc:	6442                	ld	s0,16(sp)
    80201bfe:	6105                	add	sp,sp,32
    80201c00:	8082                	ret

0000000080201c02 <_ZN5riscv8register6scause6Scause12is_interrupt17he686d69c09995befE>:
    80201c02:	7179                	add	sp,sp,-48
    80201c04:	f406                	sd	ra,40(sp)
    80201c06:	f022                	sd	s0,32(sp)
    80201c08:	1800                	add	s0,sp,48
    80201c0a:	fca43c23          	sd	a0,-40(s0)
    80201c0e:	fea43423          	sd	a0,-24(s0)
    80201c12:	04000513          	li	a0,64
    80201c16:	fea43023          	sd	a0,-32(s0)
    80201c1a:	4501                	li	a0,0
    80201c1c:	e911                	bnez	a0,80201c30 <.Lpcrel_hi0>
    80201c1e:	a009                	j	80201c20 <_ZN5riscv8register6scause6Scause12is_interrupt17he686d69c09995befE+0x1e>
    80201c20:	fe043503          	ld	a0,-32(s0)
    80201c24:	fff50593          	add	a1,a0,-1
    80201c28:	fcb43823          	sd	a1,-48(s0)
    80201c2c:	c129                	beqz	a0,80201c6e <.Lpcrel_hi3>
    80201c2e:	a005                	j	80201c4e <.Lpcrel_hi1+0x16>

0000000080201c30 <.Lpcrel_hi0>:
    80201c30:	00005517          	auipc	a0,0x5
    80201c34:	62050513          	add	a0,a0,1568 # 80207250 <str.0>

0000000080201c38 <.Lpcrel_hi1>:
    80201c38:	00005597          	auipc	a1,0x5
    80201c3c:	60058613          	add	a2,a1,1536 # 80207238 <.L__unnamed_1>
    80201c40:	02100593          	li	a1,33
    80201c44:	00004097          	auipc	ra,0x4
    80201c48:	916080e7          	jalr	-1770(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80201c4c:	0000                	unimp
    80201c4e:	fd043583          	ld	a1,-48(s0)
    80201c52:	fd843503          	ld	a0,-40(s0)

0000000080201c56 <.Lpcrel_hi2>:
    80201c56:	00005617          	auipc	a2,0x5
    80201c5a:	65260613          	add	a2,a2,1618 # 802072a8 <.L__unnamed_2>
    80201c5e:	00002097          	auipc	ra,0x2
    80201c62:	3f4080e7          	jalr	1012(ra) # 80204052 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17h8eb8d1e0f938bd7cE>
    80201c66:	70a2                	ld	ra,40(sp)
    80201c68:	7402                	ld	s0,32(sp)
    80201c6a:	6145                	add	sp,sp,48
    80201c6c:	8082                	ret

0000000080201c6e <.Lpcrel_hi3>:
    80201c6e:	00005517          	auipc	a0,0x5
    80201c72:	61250513          	add	a0,a0,1554 # 80207280 <str.1>

0000000080201c76 <.Lpcrel_hi4>:
    80201c76:	00005597          	auipc	a1,0x5
    80201c7a:	5c258613          	add	a2,a1,1474 # 80207238 <.L__unnamed_1>
    80201c7e:	02100593          	li	a1,33
    80201c82:	00004097          	auipc	ra,0x4
    80201c86:	8d8080e7          	jalr	-1832(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080201c8c <_ZN5riscv8register6scause6Scause4bits17hdcefc3e6f2c3c097E>:
    80201c8c:	1101                	add	sp,sp,-32
    80201c8e:	ec06                	sd	ra,24(sp)
    80201c90:	e822                	sd	s0,16(sp)
    80201c92:	1000                	add	s0,sp,32
    80201c94:	fea43423          	sd	a0,-24(s0)
    80201c98:	6108                	ld	a0,0(a0)
    80201c9a:	60e2                	ld	ra,24(sp)
    80201c9c:	6442                	ld	s0,16(sp)
    80201c9e:	6105                	add	sp,sp,32
    80201ca0:	8082                	ret

0000000080201ca2 <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E>:
    80201ca2:	7179                	add	sp,sp,-48
    80201ca4:	f406                	sd	ra,40(sp)
    80201ca6:	f022                	sd	s0,32(sp)
    80201ca8:	1800                	add	s0,sp,48
    80201caa:	fca43c23          	sd	a0,-40(s0)
    80201cae:	fea43423          	sd	a0,-24(s0)
    80201cb2:	00000097          	auipc	ra,0x0
    80201cb6:	f50080e7          	jalr	-176(ra) # 80201c02 <_ZN5riscv8register6scause6Scause12is_interrupt17he686d69c09995befE>
    80201cba:	e505                	bnez	a0,80201ce2 <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E+0x40>
    80201cbc:	a009                	j	80201cbe <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E+0x1c>
    80201cbe:	fd843503          	ld	a0,-40(s0)
    80201cc2:	00003097          	auipc	ra,0x3
    80201cc6:	512080e7          	jalr	1298(ra) # 802051d4 <_ZN5riscv8register6scause6Scause4code17h54ee637b5702fa83E>
    80201cca:	00003097          	auipc	ra,0x3
    80201cce:	458080e7          	jalr	1112(ra) # 80205122 <_ZN5riscv8register6scause9Exception4from17h1eca99df968464caE>
    80201cd2:	0ff57513          	zext.b	a0,a0
    80201cd6:	fea400a3          	sb	a0,-31(s0)
    80201cda:	4505                	li	a0,1
    80201cdc:	fea40023          	sb	a0,-32(s0)
    80201ce0:	a01d                	j	80201d06 <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E+0x64>
    80201ce2:	fd843503          	ld	a0,-40(s0)
    80201ce6:	00003097          	auipc	ra,0x3
    80201cea:	4ee080e7          	jalr	1262(ra) # 802051d4 <_ZN5riscv8register6scause6Scause4code17h54ee637b5702fa83E>
    80201cee:	00003097          	auipc	ra,0x3
    80201cf2:	3ba080e7          	jalr	954(ra) # 802050a8 <_ZN5riscv8register6scause9Interrupt4from17h3f999344874153e2E>
    80201cf6:	0ff57513          	zext.b	a0,a0
    80201cfa:	fea400a3          	sb	a0,-31(s0)
    80201cfe:	4501                	li	a0,0
    80201d00:	fea40023          	sb	a0,-32(s0)
    80201d04:	a009                	j	80201d06 <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E+0x64>
    80201d06:	fe044503          	lbu	a0,-32(s0)
    80201d0a:	fe140583          	lb	a1,-31(s0)
    80201d0e:	70a2                	ld	ra,40(sp)
    80201d10:	7402                	ld	s0,32(sp)
    80201d12:	6145                	add	sp,sp,48
    80201d14:	8082                	ret

0000000080201d16 <_ZN66_$LT$sbi_rt..srst..Shutdown$u20$as$u20$sbi_rt..srst..ResetType$GT$3raw17he7adfdcc96af6bb3E>:
    80201d16:	1101                	add	sp,sp,-32
    80201d18:	ec06                	sd	ra,24(sp)
    80201d1a:	e822                	sd	s0,16(sp)
    80201d1c:	1000                	add	s0,sp,32
    80201d1e:	fea43423          	sd	a0,-24(s0)
    80201d22:	4501                	li	a0,0
    80201d24:	60e2                	ld	ra,24(sp)
    80201d26:	6442                	ld	s0,16(sp)
    80201d28:	6105                	add	sp,sp,32
    80201d2a:	8082                	ret

0000000080201d2c <_ZN73_$LT$sbi_rt..srst..SystemFailure$u20$as$u20$sbi_rt..srst..ResetReason$GT$3raw17hef946130f5113183E>:
    80201d2c:	1101                	add	sp,sp,-32
    80201d2e:	ec06                	sd	ra,24(sp)
    80201d30:	e822                	sd	s0,16(sp)
    80201d32:	1000                	add	s0,sp,32
    80201d34:	fea43423          	sd	a0,-24(s0)
    80201d38:	4505                	li	a0,1
    80201d3a:	60e2                	ld	ra,24(sp)
    80201d3c:	6442                	ld	s0,16(sp)
    80201d3e:	6105                	add	sp,sp,32
    80201d40:	8082                	ret

0000000080201d42 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E>:
    80201d42:	7125                	add	sp,sp,-416
    80201d44:	ef06                	sd	ra,408(sp)
    80201d46:	eb22                	sd	s0,400(sp)
    80201d48:	1300                	add	s0,sp,416
    80201d4a:	e6c43823          	sd	a2,-400(s0)
    80201d4e:	e6b43c23          	sd	a1,-392(s0)
    80201d52:	e8a42623          	sw	a0,-372(s0)
    80201d56:	f6b43023          	sd	a1,-160(s0)
    80201d5a:	f6c43423          	sd	a2,-152(s0)
    80201d5e:	e8c42503          	lw	a0,-372(s0)
    80201d62:	08000593          	li	a1,128
    80201d66:	00b56863          	bltu	a0,a1,80201d76 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x34>
    80201d6a:	a009                	j	80201d6c <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x2a>
    80201d6c:	e8c46503          	lwu	a0,-372(s0)
    80201d70:	812d                	srl	a0,a0,0xb
    80201d72:	c125                	beqz	a0,80201dd2 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x90>
    80201d74:	a899                	j	80201dca <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x88>
    80201d76:	4505                	li	a0,1
    80201d78:	e8a43823          	sd	a0,-368(s0)
    80201d7c:	a009                	j	80201d7e <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x3c>
    80201d7e:	e7043503          	ld	a0,-400(s0)
    80201d82:	e7843583          	ld	a1,-392(s0)
    80201d86:	e9043603          	ld	a2,-368(s0)
    80201d8a:	e8c43c23          	sd	a2,-360(s0)
    80201d8e:	eab43023          	sd	a1,-352(s0)
    80201d92:	eaa43423          	sd	a0,-344(s0)
    80201d96:	e9843503          	ld	a0,-360(s0)
    80201d9a:	e6a43423          	sd	a0,-408(s0)
    80201d9e:	4585                	li	a1,1
    80201da0:	10b50463          	beq	a0,a1,80201ea8 <.Lpcrel_hi3+0x12>
    80201da4:	a009                	j	80201da6 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x64>
    80201da6:	e6843503          	ld	a0,-408(s0)
    80201daa:	4589                	li	a1,2
    80201dac:	10b50363          	beq	a0,a1,80201eb2 <.Lpcrel_hi3+0x1c>
    80201db0:	a009                	j	80201db2 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x70>
    80201db2:	e6843503          	ld	a0,-408(s0)
    80201db6:	458d                	li	a1,3
    80201db8:	10b50363          	beq	a0,a1,80201ebe <.Lpcrel_hi3+0x28>
    80201dbc:	a009                	j	80201dbe <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x7c>
    80201dbe:	e6843503          	ld	a0,-408(s0)
    80201dc2:	4591                	li	a1,4
    80201dc4:	10b50363          	beq	a0,a1,80201eca <.Lpcrel_hi3+0x34>
    80201dc8:	a01d                	j	80201dee <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xac>
    80201dca:	e8e45503          	lhu	a0,-370(s0)
    80201dce:	c919                	beqz	a0,80201de4 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xa2>
    80201dd0:	a031                	j	80201ddc <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x9a>
    80201dd2:	4509                	li	a0,2
    80201dd4:	e8a43823          	sd	a0,-368(s0)
    80201dd8:	a009                	j	80201dda <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x98>
    80201dda:	b755                	j	80201d7e <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x3c>
    80201ddc:	4511                	li	a0,4
    80201dde:	e8a43823          	sd	a0,-368(s0)
    80201de2:	a029                	j	80201dec <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xaa>
    80201de4:	450d                	li	a0,3
    80201de6:	e8a43823          	sd	a0,-368(s0)
    80201dea:	a009                	j	80201dec <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xaa>
    80201dec:	b7fd                	j	80201dda <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0x98>
    80201dee:	e7043583          	ld	a1,-400(s0)
    80201df2:	e9040613          	add	a2,s0,-368
    80201df6:	fcc43023          	sd	a2,-64(s0)

0000000080201dfa <.Lpcrel_hi0>:
    80201dfa:	00005517          	auipc	a0,0x5
    80201dfe:	98650513          	add	a0,a0,-1658 # 80206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>
    80201e02:	fca43423          	sd	a0,-56(s0)
    80201e06:	f0c43823          	sd	a2,-240(s0)
    80201e0a:	f0a43c23          	sd	a0,-232(s0)
    80201e0e:	e8c40693          	add	a3,s0,-372
    80201e12:	fcd43823          	sd	a3,-48(s0)

0000000080201e16 <.Lpcrel_hi1>:
    80201e16:	00004617          	auipc	a2,0x4
    80201e1a:	6fe60613          	add	a2,a2,1790 # 80206514 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E>
    80201e1e:	fcc43c23          	sd	a2,-40(s0)
    80201e22:	f2d43023          	sd	a3,-224(s0)
    80201e26:	f2c43423          	sd	a2,-216(s0)
    80201e2a:	f4b43023          	sd	a1,-192(s0)
    80201e2e:	f4040593          	add	a1,s0,-192
    80201e32:	feb43023          	sd	a1,-32(s0)
    80201e36:	fea43423          	sd	a0,-24(s0)
    80201e3a:	f2b43823          	sd	a1,-208(s0)
    80201e3e:	f2a43c23          	sd	a0,-200(s0)
    80201e42:	f1043583          	ld	a1,-240(s0)
    80201e46:	f1843503          	ld	a0,-232(s0)
    80201e4a:	eeb43023          	sd	a1,-288(s0)
    80201e4e:	eea43423          	sd	a0,-280(s0)
    80201e52:	f2043583          	ld	a1,-224(s0)
    80201e56:	f2843503          	ld	a0,-216(s0)
    80201e5a:	eeb43823          	sd	a1,-272(s0)
    80201e5e:	eea43c23          	sd	a0,-264(s0)
    80201e62:	f3043583          	ld	a1,-208(s0)
    80201e66:	f3843503          	ld	a0,-200(s0)
    80201e6a:	f0b43023          	sd	a1,-256(s0)
    80201e6e:	f0a43423          	sd	a0,-248(s0)

0000000080201e72 <.Lpcrel_hi2>:
    80201e72:	00005517          	auipc	a0,0x5
    80201e76:	4f650593          	add	a1,a0,1270 # 80207368 <.L__unnamed_1>
    80201e7a:	eb040513          	add	a0,s0,-336
    80201e7e:	e6a43023          	sd	a0,-416(s0)
    80201e82:	ee040693          	add	a3,s0,-288
    80201e86:	470d                	li	a4,3
    80201e88:	863a                	mv	a2,a4
    80201e8a:	00001097          	auipc	ra,0x1
    80201e8e:	4bc080e7          	jalr	1212(ra) # 80203346 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E>
    80201e92:	e6043503          	ld	a0,-416(s0)

0000000080201e96 <.Lpcrel_hi3>:
    80201e96:	00005597          	auipc	a1,0x5
    80201e9a:	50258593          	add	a1,a1,1282 # 80207398 <.L__unnamed_2>
    80201e9e:	00003097          	auipc	ra,0x3
    80201ea2:	68e080e7          	jalr	1678(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
    80201ea6:	0000                	unimp
    80201ea8:	ea843503          	ld	a0,-344(s0)
    80201eac:	14051f63          	bnez	a0,8020200a <.Lpcrel_hi4+0xa0>
    80201eb0:	bf3d                	j	80201dee <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xac>
    80201eb2:	ea843583          	ld	a1,-344(s0)
    80201eb6:	4505                	li	a0,1
    80201eb8:	10b56e63          	bltu	a0,a1,80201fd4 <.Lpcrel_hi4+0x6a>
    80201ebc:	bf0d                	j	80201dee <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xac>
    80201ebe:	ea843583          	ld	a1,-344(s0)
    80201ec2:	4509                	li	a0,2
    80201ec4:	0ab56f63          	bltu	a0,a1,80201f82 <.Lpcrel_hi4+0x18>
    80201ec8:	b71d                	j	80201dee <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xac>
    80201eca:	ea843503          	ld	a0,-344(s0)
    80201ece:	4591                	li	a1,4
    80201ed0:	f0b56fe3          	bltu	a0,a1,80201dee <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E+0xac>
    80201ed4:	a009                	j	80201ed6 <.Lpcrel_hi3+0x40>
    80201ed6:	ea043703          	ld	a4,-352(s0)
    80201eda:	f6e43823          	sd	a4,-144(s0)
    80201ede:	ea043683          	ld	a3,-352(s0)
    80201ee2:	00168513          	add	a0,a3,1
    80201ee6:	f6a43c23          	sd	a0,-136(s0)
    80201eea:	ea043603          	ld	a2,-352(s0)
    80201eee:	00260513          	add	a0,a2,2
    80201ef2:	f8a43023          	sd	a0,-128(s0)
    80201ef6:	ea043583          	ld	a1,-352(s0)
    80201efa:	00358513          	add	a0,a1,3
    80201efe:	f8a43423          	sd	a0,-120(s0)
    80201f02:	e8c42503          	lw	a0,-372(s0)
    80201f06:	152e                	sll	a0,a0,0x2b
    80201f08:	9175                	srl	a0,a0,0x3d
    80201f0a:	0f050513          	add	a0,a0,240
    80201f0e:	00a70023          	sb	a0,0(a4)
    80201f12:	e8c42503          	lw	a0,-372(s0)
    80201f16:	153a                	sll	a0,a0,0x2e
    80201f18:	9169                	srl	a0,a0,0x3a
    80201f1a:	08050513          	add	a0,a0,128
    80201f1e:	00a680a3          	sb	a0,1(a3)
    80201f22:	e8c42503          	lw	a0,-372(s0)
    80201f26:	1552                	sll	a0,a0,0x34
    80201f28:	9169                	srl	a0,a0,0x3a
    80201f2a:	08050513          	add	a0,a0,128
    80201f2e:	00a60123          	sb	a0,2(a2)
    80201f32:	e8c44503          	lbu	a0,-372(s0)
    80201f36:	03f57513          	and	a0,a0,63
    80201f3a:	08050513          	add	a0,a0,128
    80201f3e:	00a581a3          	sb	a0,3(a1)
    80201f42:	a009                	j	80201f44 <.Lpcrel_hi3+0xae>
    80201f44:	e7043683          	ld	a3,-400(s0)
    80201f48:	e7843603          	ld	a2,-392(s0)
    80201f4c:	e9043503          	ld	a0,-368(s0)
    80201f50:	f4a43423          	sd	a0,-184(s0)
    80201f54:	f4843503          	ld	a0,-184(s0)
    80201f58:	4581                	li	a1,0
    80201f5a:	f4b43823          	sd	a1,-176(s0)
    80201f5e:	f4a43c23          	sd	a0,-168(s0)
    80201f62:	f5043503          	ld	a0,-176(s0)
    80201f66:	f5843583          	ld	a1,-168(s0)

0000000080201f6a <.Lpcrel_hi4>:
    80201f6a:	00005717          	auipc	a4,0x5
    80201f6e:	3a670713          	add	a4,a4,934 # 80207310 <.L__unnamed_3>
    80201f72:	00000097          	auipc	ra,0x0
    80201f76:	9ce080e7          	jalr	-1586(ra) # 80201940 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17hb1ded6a7450467c7E>
    80201f7a:	60fa                	ld	ra,408(sp)
    80201f7c:	645a                	ld	s0,400(sp)
    80201f7e:	611d                	add	sp,sp,416
    80201f80:	8082                	ret
    80201f82:	ea043683          	ld	a3,-352(s0)
    80201f86:	f8d43823          	sd	a3,-112(s0)
    80201f8a:	ea043603          	ld	a2,-352(s0)
    80201f8e:	00160513          	add	a0,a2,1
    80201f92:	f8a43c23          	sd	a0,-104(s0)
    80201f96:	ea043583          	ld	a1,-352(s0)
    80201f9a:	00258513          	add	a0,a1,2
    80201f9e:	faa43023          	sd	a0,-96(s0)
    80201fa2:	e8c42503          	lw	a0,-372(s0)
    80201fa6:	1542                	sll	a0,a0,0x30
    80201fa8:	9171                	srl	a0,a0,0x3c
    80201faa:	0e050513          	add	a0,a0,224
    80201fae:	00a68023          	sb	a0,0(a3)
    80201fb2:	e8c42503          	lw	a0,-372(s0)
    80201fb6:	1552                	sll	a0,a0,0x34
    80201fb8:	9169                	srl	a0,a0,0x3a
    80201fba:	08050513          	add	a0,a0,128
    80201fbe:	00a600a3          	sb	a0,1(a2)
    80201fc2:	e8c44503          	lbu	a0,-372(s0)
    80201fc6:	03f57513          	and	a0,a0,63
    80201fca:	08050513          	add	a0,a0,128
    80201fce:	00a58123          	sb	a0,2(a1)
    80201fd2:	bf8d                	j	80201f44 <.Lpcrel_hi3+0xae>
    80201fd4:	ea043603          	ld	a2,-352(s0)
    80201fd8:	fac43423          	sd	a2,-88(s0)
    80201fdc:	ea043583          	ld	a1,-352(s0)
    80201fe0:	00158513          	add	a0,a1,1
    80201fe4:	faa43823          	sd	a0,-80(s0)
    80201fe8:	e8c42503          	lw	a0,-372(s0)
    80201fec:	1556                	sll	a0,a0,0x35
    80201fee:	916d                	srl	a0,a0,0x3b
    80201ff0:	0c050513          	add	a0,a0,192
    80201ff4:	00a60023          	sb	a0,0(a2)
    80201ff8:	e8c44503          	lbu	a0,-372(s0)
    80201ffc:	03f57513          	and	a0,a0,63
    80202000:	08050513          	add	a0,a0,128
    80202004:	00a580a3          	sb	a0,1(a1)
    80202008:	bf35                	j	80201f44 <.Lpcrel_hi3+0xae>
    8020200a:	ea043583          	ld	a1,-352(s0)
    8020200e:	fab43c23          	sd	a1,-72(s0)
    80202012:	e8c40503          	lb	a0,-372(s0)
    80202016:	00a58023          	sb	a0,0(a1)
    8020201a:	b72d                	j	80201f44 <.Lpcrel_hi3+0xae>

000000008020201c <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hff4f4e0bc1338e97E>:
    8020201c:	1101                	add	sp,sp,-32
    8020201e:	ec06                	sd	ra,24(sp)
    80202020:	e822                	sd	s0,16(sp)
    80202022:	1000                	add	s0,sp,32
    80202024:	fea43423          	sd	a0,-24(s0)
    80202028:	00000097          	auipc	ra,0x0
    8020202c:	9f4080e7          	jalr	-1548(ra) # 80201a1c <_ZN4core3str11validations15next_code_point17h19a3ffaf9cc49393E>
    80202030:	fffff097          	auipc	ra,0xfffff
    80202034:	676080e7          	jalr	1654(ra) # 802016a6 <_ZN4core6option15Option$LT$T$GT$3map17h88517e4a207e4ef5E>
    80202038:	1502                	sll	a0,a0,0x20
    8020203a:	9101                	srl	a0,a0,0x20
    8020203c:	60e2                	ld	ra,24(sp)
    8020203e:	6442                	ld	s0,16(sp)
    80202040:	6105                	add	sp,sp,32
    80202042:	8082                	ret

0000000080202044 <_ZN4core3fmt5Write10write_char17h39fcf4924093cb1bE>:
    80202044:	711d                	add	sp,sp,-96
    80202046:	ec86                	sd	ra,88(sp)
    80202048:	e8a2                	sd	s0,80(sp)
    8020204a:	1080                	add	s0,sp,96
    8020204c:	fab43023          	sd	a1,-96(s0)
    80202050:	85aa                	mv	a1,a0
    80202052:	fa043503          	ld	a0,-96(s0)
    80202056:	fab43423          	sd	a1,-88(s0)
    8020205a:	fcb43023          	sd	a1,-64(s0)
    8020205e:	fca42623          	sw	a0,-52(s0)
    80202062:	4581                	li	a1,0
    80202064:	fab42e23          	sw	a1,-68(s0)
    80202068:	fbc40593          	add	a1,s0,-68
    8020206c:	fcb43823          	sd	a1,-48(s0)
    80202070:	4611                	li	a2,4
    80202072:	fcc43c23          	sd	a2,-40(s0)
    80202076:	00000097          	auipc	ra,0x0
    8020207a:	ccc080e7          	jalr	-820(ra) # 80201d42 <_ZN4core4char7methods15encode_utf8_raw17hf847da296d675469E>
    8020207e:	862a                	mv	a2,a0
    80202080:	fa843503          	ld	a0,-88(s0)
    80202084:	fac43823          	sd	a2,-80(s0)
    80202088:	862e                	mv	a2,a1
    8020208a:	fb043583          	ld	a1,-80(s0)
    8020208e:	feb43023          	sd	a1,-32(s0)
    80202092:	fec43423          	sd	a2,-24(s0)
    80202096:	00000097          	auipc	ra,0x0
    8020209a:	47c080e7          	jalr	1148(ra) # 80202512 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E>
    8020209e:	60e6                	ld	ra,88(sp)
    802020a0:	6446                	ld	s0,80(sp)
    802020a2:	6125                	add	sp,sp,96
    802020a4:	8082                	ret

00000000802020a6 <_ZN4core3fmt5Write9write_fmt17hb7ebeeca2383bfb8E>:
    802020a6:	715d                	add	sp,sp,-80
    802020a8:	e486                	sd	ra,72(sp)
    802020aa:	e0a2                	sd	s0,64(sp)
    802020ac:	0880                	add	s0,sp,80
    802020ae:	faa43c23          	sd	a0,-72(s0)
    802020b2:	7588                	ld	a0,40(a1)
    802020b4:	fea43423          	sd	a0,-24(s0)
    802020b8:	7188                	ld	a0,32(a1)
    802020ba:	fea43023          	sd	a0,-32(s0)
    802020be:	6d88                	ld	a0,24(a1)
    802020c0:	fca43c23          	sd	a0,-40(s0)
    802020c4:	6988                	ld	a0,16(a1)
    802020c6:	fca43823          	sd	a0,-48(s0)
    802020ca:	6588                	ld	a0,8(a1)
    802020cc:	fca43423          	sd	a0,-56(s0)
    802020d0:	6188                	ld	a0,0(a1)
    802020d2:	fca43023          	sd	a0,-64(s0)

00000000802020d6 <.Lpcrel_hi0>:
    802020d6:	00005517          	auipc	a0,0x5
    802020da:	2da50593          	add	a1,a0,730 # 802073b0 <.L__unnamed_1>
    802020de:	fb840513          	add	a0,s0,-72
    802020e2:	fc040613          	add	a2,s0,-64
    802020e6:	00004097          	auipc	ra,0x4
    802020ea:	9e6080e7          	jalr	-1562(ra) # 80205acc <_ZN4core3fmt5write17h725a6c334848b4a3E>
    802020ee:	60a6                	ld	ra,72(sp)
    802020f0:	6406                	ld	s0,64(sp)
    802020f2:	6161                	add	sp,sp,80
    802020f4:	8082                	ret

00000000802020f6 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf4c50a606b3ea894E>:
    802020f6:	1101                	add	sp,sp,-32
    802020f8:	ec06                	sd	ra,24(sp)
    802020fa:	e822                	sd	s0,16(sp)
    802020fc:	1000                	add	s0,sp,32
    802020fe:	fea43023          	sd	a0,-32(s0)
    80202102:	feb42623          	sw	a1,-20(s0)
    80202106:	6108                	ld	a0,0(a0)
    80202108:	00000097          	auipc	ra,0x0
    8020210c:	f3c080e7          	jalr	-196(ra) # 80202044 <_ZN4core3fmt5Write10write_char17h39fcf4924093cb1bE>
    80202110:	60e2                	ld	ra,24(sp)
    80202112:	6442                	ld	s0,16(sp)
    80202114:	6105                	add	sp,sp,32
    80202116:	8082                	ret

0000000080202118 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hdabf956900477224E>:
    80202118:	715d                	add	sp,sp,-80
    8020211a:	e486                	sd	ra,72(sp)
    8020211c:	e0a2                	sd	s0,64(sp)
    8020211e:	0880                	add	s0,sp,80
    80202120:	faa43c23          	sd	a0,-72(s0)
    80202124:	6108                	ld	a0,0(a0)
    80202126:	7590                	ld	a2,40(a1)
    80202128:	fec43423          	sd	a2,-24(s0)
    8020212c:	7190                	ld	a2,32(a1)
    8020212e:	fec43023          	sd	a2,-32(s0)
    80202132:	6d90                	ld	a2,24(a1)
    80202134:	fcc43c23          	sd	a2,-40(s0)
    80202138:	6990                	ld	a2,16(a1)
    8020213a:	fcc43823          	sd	a2,-48(s0)
    8020213e:	6590                	ld	a2,8(a1)
    80202140:	fcc43423          	sd	a2,-56(s0)
    80202144:	618c                	ld	a1,0(a1)
    80202146:	fcb43023          	sd	a1,-64(s0)
    8020214a:	fc040593          	add	a1,s0,-64
    8020214e:	00000097          	auipc	ra,0x0
    80202152:	f58080e7          	jalr	-168(ra) # 802020a6 <_ZN4core3fmt5Write9write_fmt17hb7ebeeca2383bfb8E>
    80202156:	60a6                	ld	ra,72(sp)
    80202158:	6406                	ld	s0,64(sp)
    8020215a:	6161                	add	sp,sp,80
    8020215c:	8082                	ret

000000008020215e <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h6d1bb0f028bd24e7E>:
    8020215e:	7179                	add	sp,sp,-48
    80202160:	f406                	sd	ra,40(sp)
    80202162:	f022                	sd	s0,32(sp)
    80202164:	1800                	add	s0,sp,48
    80202166:	fca43c23          	sd	a0,-40(s0)
    8020216a:	feb43023          	sd	a1,-32(s0)
    8020216e:	fec43423          	sd	a2,-24(s0)
    80202172:	6108                	ld	a0,0(a0)
    80202174:	00000097          	auipc	ra,0x0
    80202178:	39e080e7          	jalr	926(ra) # 80202512 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E>
    8020217c:	70a2                	ld	ra,40(sp)
    8020217e:	7402                	ld	s0,32(sp)
    80202180:	6145                	add	sp,sp,48
    80202182:	8082                	ret

0000000080202184 <_ZN4core3mem6forget17h02cc43c52e69d99aE>:
    80202184:	1101                	add	sp,sp,-32
    80202186:	ec06                	sd	ra,24(sp)
    80202188:	e822                	sd	s0,16(sp)
    8020218a:	1000                	add	s0,sp,32
    8020218c:	fea43423          	sd	a0,-24(s0)
    80202190:	60e2                	ld	ra,24(sp)
    80202192:	6442                	ld	s0,16(sp)
    80202194:	6105                	add	sp,sp,32
    80202196:	8082                	ret

0000000080202198 <_ZN5alloc3vec12Vec$LT$T$GT$3new17h4439be25237b218cE>:
    80202198:	1141                	add	sp,sp,-16
    8020219a:	e406                	sd	ra,8(sp)
    8020219c:	e022                	sd	s0,0(sp)
    8020219e:	0800                	add	s0,sp,16
    802021a0:	85aa                	mv	a1,a0

00000000802021a2 <.Lpcrel_hi0>:
    802021a2:	00005517          	auipc	a0,0x5
    802021a6:	23e50513          	add	a0,a0,574 # 802073e0 <.L__unnamed_1+0x30>
    802021aa:	6110                	ld	a2,0(a0)
    802021ac:	6508                	ld	a0,8(a0)
    802021ae:	e190                	sd	a2,0(a1)
    802021b0:	e588                	sd	a0,8(a1)
    802021b2:	4501                	li	a0,0
    802021b4:	e988                	sd	a0,16(a1)
    802021b6:	60a2                	ld	ra,8(sp)
    802021b8:	6402                	ld	s0,0(sp)
    802021ba:	0141                	add	sp,sp,16
    802021bc:	8082                	ret

00000000802021be <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E>:
    802021be:	7155                	add	sp,sp,-208
    802021c0:	e586                	sd	ra,200(sp)
    802021c2:	e1a2                	sd	s0,192(sp)
    802021c4:	0980                	add	s0,sp,208
    802021c6:	f2b43c23          	sd	a1,-200(s0)
    802021ca:	f4a43023          	sd	a0,-192(s0)
    802021ce:	f8a43423          	sd	a0,-120(s0)
    802021d2:	f8b43823          	sd	a1,-112(s0)
    802021d6:	f8a43c23          	sd	a0,-104(s0)
    802021da:	f6a43823          	sd	a0,-144(s0)
    802021de:	f7043503          	ld	a0,-144(s0)
    802021e2:	faa43023          	sd	a0,-96(s0)
    802021e6:	4501                	li	a0,0
    802021e8:	ed11                	bnez	a0,80202204 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E+0x46>
    802021ea:	a009                	j	802021ec <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E+0x2e>
    802021ec:	f4043503          	ld	a0,-192(s0)
    802021f0:	f3843583          	ld	a1,-200(s0)
    802021f4:	fcb43c23          	sd	a1,-40(s0)
    802021f8:	feb43023          	sd	a1,-32(s0)
    802021fc:	952e                	add	a0,a0,a1
    802021fe:	f6a43023          	sd	a0,-160(s0)
    80202202:	a83d                	j	80202240 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E+0x82>
    80202204:	f4043503          	ld	a0,-192(s0)
    80202208:	f3843583          	ld	a1,-200(s0)
    8020220c:	fab43423          	sd	a1,-88(s0)
    80202210:	faa43823          	sd	a0,-80(s0)
    80202214:	fab43c23          	sd	a1,-72(s0)
    80202218:	952e                	add	a0,a0,a1
    8020221a:	fca43023          	sd	a0,-64(s0)
    8020221e:	fc043503          	ld	a0,-64(s0)
    80202222:	fca43423          	sd	a0,-56(s0)
    80202226:	fca43823          	sd	a0,-48(s0)
    8020222a:	f8a43023          	sd	a0,-128(s0)
    8020222e:	f8043503          	ld	a0,-128(s0)
    80202232:	f6a43c23          	sd	a0,-136(s0)
    80202236:	f7843503          	ld	a0,-136(s0)
    8020223a:	f6a43023          	sd	a0,-160(s0)
    8020223e:	a009                	j	80202240 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h90a1ed07e005e5e9E+0x82>
    80202240:	f4043503          	ld	a0,-192(s0)
    80202244:	fea43423          	sd	a0,-24(s0)
    80202248:	f6a43423          	sd	a0,-152(s0)
    8020224c:	f6043503          	ld	a0,-160(s0)
    80202250:	f6843583          	ld	a1,-152(s0)
    80202254:	f4b43c23          	sd	a1,-168(s0)
    80202258:	f4a43823          	sd	a0,-176(s0)
    8020225c:	f5043503          	ld	a0,-176(s0)
    80202260:	f5843583          	ld	a1,-168(s0)
    80202264:	60ae                	ld	ra,200(sp)
    80202266:	640e                	ld	s0,192(sp)
    80202268:	6169                	add	sp,sp,208
    8020226a:	8082                	ret

000000008020226c <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E>:
    8020226c:	7155                	add	sp,sp,-208
    8020226e:	e586                	sd	ra,200(sp)
    80202270:	e1a2                	sd	s0,192(sp)
    80202272:	0980                	add	s0,sp,208
    80202274:	f2b43c23          	sd	a1,-200(s0)
    80202278:	f4a43023          	sd	a0,-192(s0)
    8020227c:	f8a43423          	sd	a0,-120(s0)
    80202280:	f8b43823          	sd	a1,-112(s0)
    80202284:	f8a43c23          	sd	a0,-104(s0)
    80202288:	f6a43823          	sd	a0,-144(s0)
    8020228c:	f7043503          	ld	a0,-144(s0)
    80202290:	faa43023          	sd	a0,-96(s0)
    80202294:	4501                	li	a0,0
    80202296:	e115                	bnez	a0,802022ba <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E+0x4e>
    80202298:	a009                	j	8020229a <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E+0x2e>
    8020229a:	f4043503          	ld	a0,-192(s0)
    8020229e:	f3843583          	ld	a1,-200(s0)
    802022a2:	fcb43c23          	sd	a1,-40(s0)
    802022a6:	feb43023          	sd	a1,-32(s0)
    802022aa:	952e                	add	a0,a0,a1
    802022ac:	fea43423          	sd	a0,-24(s0)
    802022b0:	fe843503          	ld	a0,-24(s0)
    802022b4:	f6a43023          	sd	a0,-160(s0)
    802022b8:	a83d                	j	802022f6 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E+0x8a>
    802022ba:	f4043503          	ld	a0,-192(s0)
    802022be:	f3843583          	ld	a1,-200(s0)
    802022c2:	fab43423          	sd	a1,-88(s0)
    802022c6:	faa43823          	sd	a0,-80(s0)
    802022ca:	fab43c23          	sd	a1,-72(s0)
    802022ce:	952e                	add	a0,a0,a1
    802022d0:	fca43023          	sd	a0,-64(s0)
    802022d4:	fc043503          	ld	a0,-64(s0)
    802022d8:	fca43423          	sd	a0,-56(s0)
    802022dc:	fca43823          	sd	a0,-48(s0)
    802022e0:	f8a43023          	sd	a0,-128(s0)
    802022e4:	f8043503          	ld	a0,-128(s0)
    802022e8:	f6a43c23          	sd	a0,-136(s0)
    802022ec:	f7843503          	ld	a0,-136(s0)
    802022f0:	f6a43023          	sd	a0,-160(s0)
    802022f4:	a009                	j	802022f6 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E+0x8a>
    802022f6:	f4043503          	ld	a0,-192(s0)
    802022fa:	f6a43423          	sd	a0,-152(s0)
    802022fe:	f6043503          	ld	a0,-160(s0)
    80202302:	f6843583          	ld	a1,-152(s0)
    80202306:	f4b43c23          	sd	a1,-168(s0)
    8020230a:	f4a43823          	sd	a0,-176(s0)
    8020230e:	f5043503          	ld	a0,-176(s0)
    80202312:	f5843583          	ld	a1,-168(s0)
    80202316:	60ae                	ld	ra,200(sp)
    80202318:	640e                	ld	s0,192(sp)
    8020231a:	6169                	add	sp,sp,208
    8020231c:	8082                	ret

000000008020231e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E>:
    8020231e:	7111                	add	sp,sp,-256
    80202320:	fd86                	sd	ra,248(sp)
    80202322:	f9a2                	sd	s0,240(sp)
    80202324:	0200                	add	s0,sp,256
    80202326:	f0a43023          	sd	a0,-256(s0)
    8020232a:	f4a43423          	sd	a0,-184(s0)
    8020232e:	6508                	ld	a0,8(a0)
    80202330:	f4a43823          	sd	a0,-176(s0)
    80202334:	f4a43c23          	sd	a0,-168(s0)
    80202338:	f2a43023          	sd	a0,-224(s0)
    8020233c:	f2043503          	ld	a0,-224(s0)
    80202340:	f6a43023          	sd	a0,-160(s0)
    80202344:	4505                	li	a0,1
    80202346:	e919                	bnez	a0,8020235c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x3e>
    80202348:	a009                	j	8020234a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x2c>
    8020234a:	f0043583          	ld	a1,-256(s0)
    8020234e:	6588                	ld	a0,8(a1)
    80202350:	f6a43c23          	sd	a0,-136(s0)
    80202354:	618c                	ld	a1,0(a1)
    80202356:	02b50263          	beq	a0,a1,8020237a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x5c>
    8020235a:	a829                	j	80202374 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x56>
    8020235c:	f0043503          	ld	a0,-256(s0)
    80202360:	6108                	ld	a0,0(a0)
    80202362:	f6a43423          	sd	a0,-152(s0)
    80202366:	f2a43423          	sd	a0,-216(s0)
    8020236a:	f2843503          	ld	a0,-216(s0)
    8020236e:	f6a43823          	sd	a0,-144(s0)
    80202372:	bfe1                	j	8020234a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x2c>
    80202374:	4501                	li	a0,0
    80202376:	ed01                	bnez	a0,8020238e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x70>
    80202378:	a8a9                	j	802023d2 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0xb4>
    8020237a:	4501                	li	a0,0
    8020237c:	f0a43823          	sd	a0,-240(s0)
    80202380:	a009                	j	80202382 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x64>
    80202382:	f1043503          	ld	a0,-240(s0)
    80202386:	70ee                	ld	ra,248(sp)
    80202388:	744e                	ld	s0,240(sp)
    8020238a:	6111                	add	sp,sp,256
    8020238c:	8082                	ret
    8020238e:	f0043503          	ld	a0,-256(s0)
    80202392:	610c                	ld	a1,0(a0)
    80202394:	fab43c23          	sd	a1,-72(s0)
    80202398:	fcb43023          	sd	a1,-64(s0)
    8020239c:	567d                	li	a2,-1
    8020239e:	fcc43423          	sd	a2,-56(s0)
    802023a2:	15fd                	add	a1,a1,-1
    802023a4:	fcb43823          	sd	a1,-48(s0)
    802023a8:	fd043583          	ld	a1,-48(s0)
    802023ac:	fcb43c23          	sd	a1,-40(s0)
    802023b0:	feb43023          	sd	a1,-32(s0)
    802023b4:	f4b43023          	sd	a1,-192(s0)
    802023b8:	f4043583          	ld	a1,-192(s0)
    802023bc:	f2b43c23          	sd	a1,-200(s0)
    802023c0:	f3843583          	ld	a1,-200(s0)
    802023c4:	e10c                	sd	a1,0(a0)
    802023c6:	6508                	ld	a0,8(a0)
    802023c8:	fea43423          	sd	a0,-24(s0)
    802023cc:	f0a43c23          	sd	a0,-232(s0)
    802023d0:	a83d                	j	8020240e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0xf0>
    802023d2:	f0043603          	ld	a2,-256(s0)
    802023d6:	6608                	ld	a0,8(a2)
    802023d8:	f8a43023          	sd	a0,-128(s0)
    802023dc:	f8a43423          	sd	a0,-120(s0)
    802023e0:	660c                	ld	a1,8(a2)
    802023e2:	f8b43823          	sd	a1,-112(s0)
    802023e6:	f8b43c23          	sd	a1,-104(s0)
    802023ea:	4685                	li	a3,1
    802023ec:	fad43023          	sd	a3,-96(s0)
    802023f0:	0585                	add	a1,a1,1
    802023f2:	fab43423          	sd	a1,-88(s0)
    802023f6:	fa843583          	ld	a1,-88(s0)
    802023fa:	fab43823          	sd	a1,-80(s0)
    802023fe:	f2b43823          	sd	a1,-208(s0)
    80202402:	f3043583          	ld	a1,-208(s0)
    80202406:	e60c                	sd	a1,8(a2)
    80202408:	f0a43c23          	sd	a0,-232(s0)
    8020240c:	a009                	j	8020240e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0xf0>
    8020240e:	f1843503          	ld	a0,-232(s0)
    80202412:	f0a43823          	sd	a0,-240(s0)
    80202416:	b7b5                	j	80202382 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h0e57da20c91d3010E+0x64>

0000000080202418 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E>:
    80202418:	7111                	add	sp,sp,-256
    8020241a:	fd86                	sd	ra,248(sp)
    8020241c:	f9a2                	sd	s0,240(sp)
    8020241e:	0200                	add	s0,sp,256
    80202420:	f0a43023          	sd	a0,-256(s0)
    80202424:	f4a43423          	sd	a0,-184(s0)
    80202428:	6508                	ld	a0,8(a0)
    8020242a:	f4a43823          	sd	a0,-176(s0)
    8020242e:	f4a43c23          	sd	a0,-168(s0)
    80202432:	f2a43023          	sd	a0,-224(s0)
    80202436:	f2043503          	ld	a0,-224(s0)
    8020243a:	f6a43023          	sd	a0,-160(s0)
    8020243e:	4505                	li	a0,1
    80202440:	e919                	bnez	a0,80202456 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x3e>
    80202442:	a009                	j	80202444 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x2c>
    80202444:	f0043583          	ld	a1,-256(s0)
    80202448:	6588                	ld	a0,8(a1)
    8020244a:	f6a43c23          	sd	a0,-136(s0)
    8020244e:	618c                	ld	a1,0(a1)
    80202450:	02b50263          	beq	a0,a1,80202474 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x5c>
    80202454:	a829                	j	8020246e <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x56>
    80202456:	f0043503          	ld	a0,-256(s0)
    8020245a:	6108                	ld	a0,0(a0)
    8020245c:	f6a43423          	sd	a0,-152(s0)
    80202460:	f2a43423          	sd	a0,-216(s0)
    80202464:	f2843503          	ld	a0,-216(s0)
    80202468:	f6a43823          	sd	a0,-144(s0)
    8020246c:	bfe1                	j	80202444 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x2c>
    8020246e:	4501                	li	a0,0
    80202470:	ed01                	bnez	a0,80202488 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x70>
    80202472:	a8a9                	j	802024cc <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0xb4>
    80202474:	4501                	li	a0,0
    80202476:	f0a43823          	sd	a0,-240(s0)
    8020247a:	a009                	j	8020247c <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x64>
    8020247c:	f1043503          	ld	a0,-240(s0)
    80202480:	70ee                	ld	ra,248(sp)
    80202482:	744e                	ld	s0,240(sp)
    80202484:	6111                	add	sp,sp,256
    80202486:	8082                	ret
    80202488:	f0043503          	ld	a0,-256(s0)
    8020248c:	610c                	ld	a1,0(a0)
    8020248e:	fab43c23          	sd	a1,-72(s0)
    80202492:	fcb43023          	sd	a1,-64(s0)
    80202496:	567d                	li	a2,-1
    80202498:	fcc43423          	sd	a2,-56(s0)
    8020249c:	15fd                	add	a1,a1,-1
    8020249e:	fcb43823          	sd	a1,-48(s0)
    802024a2:	fd043583          	ld	a1,-48(s0)
    802024a6:	fcb43c23          	sd	a1,-40(s0)
    802024aa:	feb43023          	sd	a1,-32(s0)
    802024ae:	f4b43023          	sd	a1,-192(s0)
    802024b2:	f4043583          	ld	a1,-192(s0)
    802024b6:	f2b43c23          	sd	a1,-200(s0)
    802024ba:	f3843583          	ld	a1,-200(s0)
    802024be:	e10c                	sd	a1,0(a0)
    802024c0:	6508                	ld	a0,8(a0)
    802024c2:	fea43423          	sd	a0,-24(s0)
    802024c6:	f0a43c23          	sd	a0,-232(s0)
    802024ca:	a83d                	j	80202508 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0xf0>
    802024cc:	f0043603          	ld	a2,-256(s0)
    802024d0:	6608                	ld	a0,8(a2)
    802024d2:	f8a43023          	sd	a0,-128(s0)
    802024d6:	f8a43423          	sd	a0,-120(s0)
    802024da:	660c                	ld	a1,8(a2)
    802024dc:	f8b43823          	sd	a1,-112(s0)
    802024e0:	f8b43c23          	sd	a1,-104(s0)
    802024e4:	4685                	li	a3,1
    802024e6:	fad43023          	sd	a3,-96(s0)
    802024ea:	0585                	add	a1,a1,1
    802024ec:	fab43423          	sd	a1,-88(s0)
    802024f0:	fa843583          	ld	a1,-88(s0)
    802024f4:	fab43823          	sd	a1,-80(s0)
    802024f8:	f2b43823          	sd	a1,-208(s0)
    802024fc:	f3043583          	ld	a1,-208(s0)
    80202500:	e60c                	sd	a1,8(a2)
    80202502:	f0a43c23          	sd	a0,-232(s0)
    80202506:	a009                	j	80202508 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0xf0>
    80202508:	f1843503          	ld	a0,-232(s0)
    8020250c:	f0a43823          	sd	a0,-240(s0)
    80202510:	b7b5                	j	8020247c <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E+0x64>

0000000080202512 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E>:
    80202512:	711d                	add	sp,sp,-96
    80202514:	ec86                	sd	ra,88(sp)
    80202516:	e8a2                	sd	s0,80(sp)
    80202518:	1080                	add	s0,sp,96
    8020251a:	fac43423          	sd	a2,-88(s0)
    8020251e:	862e                	mv	a2,a1
    80202520:	fa843583          	ld	a1,-88(s0)
    80202524:	fac43823          	sd	a2,-80(s0)
    80202528:	862a                	mv	a2,a0
    8020252a:	fb043503          	ld	a0,-80(s0)
    8020252e:	fcc43823          	sd	a2,-48(s0)
    80202532:	fca43c23          	sd	a0,-40(s0)
    80202536:	feb43023          	sd	a1,-32(s0)
    8020253a:	fffff097          	auipc	ra,0xfffff
    8020253e:	39e080e7          	jalr	926(ra) # 802018d8 <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17hdd2b385b55eca399E>
    80202542:	fffff097          	auipc	ra,0xfffff
    80202546:	abe080e7          	jalr	-1346(ra) # 80201000 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h741d95d089067998E>
    8020254a:	faa43c23          	sd	a0,-72(s0)
    8020254e:	fcb43023          	sd	a1,-64(s0)
    80202552:	a009                	j	80202554 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E+0x42>
    80202554:	fb840513          	add	a0,s0,-72
    80202558:	00000097          	auipc	ra,0x0
    8020255c:	ac4080e7          	jalr	-1340(ra) # 8020201c <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hff4f4e0bc1338e97E>
    80202560:	997d                	and	a0,a0,-1
    80202562:	fca42623          	sw	a0,-52(s0)
    80202566:	fcc42503          	lw	a0,-52(s0)
    8020256a:	001105b7          	lui	a1,0x110
    8020256e:	00b51863          	bne	a0,a1,8020257e <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E+0x6c>
    80202572:	a009                	j	80202574 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E+0x62>
    80202574:	4501                	li	a0,0
    80202576:	60e6                	ld	ra,88(sp)
    80202578:	6446                	ld	s0,80(sp)
    8020257a:	6125                	add	sp,sp,96
    8020257c:	8082                	ret
    8020257e:	fcc46503          	lwu	a0,-52(s0)
    80202582:	fea42623          	sw	a0,-20(s0)
    80202586:	00001097          	auipc	ra,0x1
    8020258a:	0f8080e7          	jalr	248(ra) # 8020367e <_ZN11hello_world3sbi15console_putchar17h42168a51a2978df3E>
    8020258e:	b7d9                	j	80202554 <_ZN65_$LT$hello_world..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h7fb12426ce0364a8E+0x42>

0000000080202590 <_ZN11hello_world7console5print17hf85a3294b456942fE>:
    80202590:	715d                	add	sp,sp,-80
    80202592:	e486                	sd	ra,72(sp)
    80202594:	e0a2                	sd	s0,64(sp)
    80202596:	0880                	add	s0,sp,80
    80202598:	750c                	ld	a1,40(a0)
    8020259a:	feb43423          	sd	a1,-24(s0)
    8020259e:	710c                	ld	a1,32(a0)
    802025a0:	feb43023          	sd	a1,-32(s0)
    802025a4:	6d0c                	ld	a1,24(a0)
    802025a6:	fcb43c23          	sd	a1,-40(s0)
    802025aa:	690c                	ld	a1,16(a0)
    802025ac:	fcb43823          	sd	a1,-48(s0)
    802025b0:	650c                	ld	a1,8(a0)
    802025b2:	fcb43423          	sd	a1,-56(s0)
    802025b6:	6108                	ld	a0,0(a0)
    802025b8:	fca43023          	sd	a0,-64(s0)
    802025bc:	fb840513          	add	a0,s0,-72
    802025c0:	fc040593          	add	a1,s0,-64
    802025c4:	00000097          	auipc	ra,0x0
    802025c8:	ae2080e7          	jalr	-1310(ra) # 802020a6 <_ZN4core3fmt5Write9write_fmt17hb7ebeeca2383bfb8E>

00000000802025cc <.Lpcrel_hi0>:
    802025cc:	00005597          	auipc	a1,0x5
    802025d0:	e6458593          	add	a1,a1,-412 # 80207430 <.L__unnamed_1>
    802025d4:	00001097          	auipc	ra,0x1
    802025d8:	5ee080e7          	jalr	1518(ra) # 80203bc2 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8fc13925b6d41ff6E>
    802025dc:	60a6                	ld	ra,72(sp)
    802025de:	6406                	ld	s0,64(sp)
    802025e0:	6161                	add	sp,sp,80
    802025e2:	8082                	ret

00000000802025e4 <_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17hf55b682a3dee0d52E>:
    802025e4:	1101                	add	sp,sp,-32
    802025e6:	ec06                	sd	ra,24(sp)
    802025e8:	e822                	sd	s0,16(sp)
    802025ea:	1000                	add	s0,sp,32
    802025ec:	fea43423          	sd	a0,-24(s0)
    802025f0:	60e2                	ld	ra,24(sp)
    802025f2:	6442                	ld	s0,16(sp)
    802025f4:	6105                	add	sp,sp,32
    802025f6:	8082                	ret

00000000802025f8 <_ZN4core3ptr61drop_in_place$LT$$RF$mut$u20$hello_world..console..Stdout$GT$17h39733060a63594b9E>:
    802025f8:	1101                	add	sp,sp,-32
    802025fa:	ec06                	sd	ra,24(sp)
    802025fc:	e822                	sd	s0,16(sp)
    802025fe:	1000                	add	s0,sp,32
    80202600:	fea43423          	sd	a0,-24(s0)
    80202604:	60e2                	ld	ra,24(sp)
    80202606:	6442                	ld	s0,16(sp)
    80202608:	6105                	add	sp,sp,32
    8020260a:	8082                	ret

000000008020260c <_ZN5riscv8register7sstatus4read17h474c3adc66f37ec2E>:
    8020260c:	1101                	add	sp,sp,-32
    8020260e:	ec06                	sd	ra,24(sp)
    80202610:	e822                	sd	s0,16(sp)
    80202612:	1000                	add	s0,sp,32
    80202614:	00000097          	auipc	ra,0x0
    80202618:	018080e7          	jalr	24(ra) # 8020262c <_ZN5riscv8register7sstatus5_read17h333d9f6e499a1e13E>
    8020261c:	fea43423          	sd	a0,-24(s0)
    80202620:	fe843503          	ld	a0,-24(s0)
    80202624:	60e2                	ld	ra,24(sp)
    80202626:	6442                	ld	s0,16(sp)
    80202628:	6105                	add	sp,sp,32
    8020262a:	8082                	ret

000000008020262c <_ZN5riscv8register7sstatus5_read17h333d9f6e499a1e13E>:
    8020262c:	1101                	add	sp,sp,-32
    8020262e:	ec06                	sd	ra,24(sp)
    80202630:	e822                	sd	s0,16(sp)
    80202632:	1000                	add	s0,sp,32
    80202634:	10002573          	csrr	a0,sstatus
    80202638:	fea43423          	sd	a0,-24(s0)
    8020263c:	fe843503          	ld	a0,-24(s0)
    80202640:	60e2                	ld	ra,24(sp)
    80202642:	6442                	ld	s0,16(sp)
    80202644:	6105                	add	sp,sp,32
    80202646:	8082                	ret

0000000080202648 <_ZN5riscv8register7sstatus7Sstatus4bits17h8ffdaa3b08d0261cE>:
    80202648:	1101                	add	sp,sp,-32
    8020264a:	ec06                	sd	ra,24(sp)
    8020264c:	e822                	sd	s0,16(sp)
    8020264e:	1000                	add	s0,sp,32
    80202650:	fea43423          	sd	a0,-24(s0)
    80202654:	6108                	ld	a0,0(a0)
    80202656:	60e2                	ld	ra,24(sp)
    80202658:	6442                	ld	s0,16(sp)
    8020265a:	6105                	add	sp,sp,32
    8020265c:	8082                	ret

000000008020265e <_ZN5riscv8register7sstatus7Sstatus7set_spp17h4623bbd2c56ae136E>:
    8020265e:	7179                	add	sp,sp,-48
    80202660:	f406                	sd	ra,40(sp)
    80202662:	f022                	sd	s0,32(sp)
    80202664:	1800                	add	s0,sp,48
    80202666:	fca43c23          	sd	a0,-40(s0)
    8020266a:	feb403a3          	sb	a1,-25(s0)
    8020266e:	fea43423          	sd	a0,-24(s0)

0000000080202672 <.Lpcrel_hi0>:
    80202672:	00005517          	auipc	a0,0x5
    80202676:	dd650593          	add	a1,a0,-554 # 80207448 <.L__unnamed_1>
    8020267a:	fe740513          	add	a0,s0,-25
    8020267e:	00000097          	auipc	ra,0x0
    80202682:	028080e7          	jalr	40(ra) # 802026a6 <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17hfa0e167d5ca31049E>
    80202686:	862a                	mv	a2,a0
    80202688:	fd843503          	ld	a0,-40(s0)

000000008020268c <.Lpcrel_hi1>:
    8020268c:	00005597          	auipc	a1,0x5
    80202690:	e1c58693          	add	a3,a1,-484 # 802074a8 <.L__unnamed_2>
    80202694:	45a1                	li	a1,8
    80202696:	00002097          	auipc	ra,0x2
    8020269a:	a44080e7          	jalr	-1468(ra) # 802040da <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17h27dfc59eebaa642fE>
    8020269e:	70a2                	ld	ra,40(sp)
    802026a0:	7402                	ld	s0,32(sp)
    802026a2:	6145                	add	sp,sp,48
    802026a4:	8082                	ret

00000000802026a6 <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17hfa0e167d5ca31049E>:
    802026a6:	7179                	add	sp,sp,-48
    802026a8:	f406                	sd	ra,40(sp)
    802026aa:	f022                	sd	s0,32(sp)
    802026ac:	1800                	add	s0,sp,48
    802026ae:	fca43823          	sd	a0,-48(s0)
    802026b2:	fcb43c23          	sd	a1,-40(s0)
    802026b6:	00054503          	lbu	a0,0(a0)
    802026ba:	fea43023          	sd	a0,-32(s0)
    802026be:	0005c583          	lbu	a1,0(a1)
    802026c2:	feb43423          	sd	a1,-24(s0)
    802026c6:	8d2d                	xor	a0,a0,a1
    802026c8:	00153513          	seqz	a0,a0
    802026cc:	70a2                	ld	ra,40(sp)
    802026ce:	7402                	ld	s0,32(sp)
    802026d0:	6145                	add	sp,sp,48
    802026d2:	8082                	ret

00000000802026d4 <_ZN4core4sync6atomic11atomic_load17habdcb365fcee2ab0E>:
    802026d4:	7135                	add	sp,sp,-160
    802026d6:	ed06                	sd	ra,152(sp)
    802026d8:	e922                	sd	s0,144(sp)
    802026da:	1100                	add	s0,sp,160
    802026dc:	f6a43823          	sd	a0,-144(s0)
    802026e0:	f8b40323          	sb	a1,-122(s0)
    802026e4:	fea43423          	sd	a0,-24(s0)
    802026e8:	f8644503          	lbu	a0,-122(s0)
    802026ec:	f6a43c23          	sd	a0,-136(s0)
    802026f0:	f7843503          	ld	a0,-136(s0)
    802026f4:	050e                	sll	a0,a0,0x3

00000000802026f6 <.Lpcrel_hi0>:
    802026f6:	00005597          	auipc	a1,0x5
    802026fa:	dca58593          	add	a1,a1,-566 # 802074c0 <.LJTI0_0>
    802026fe:	952e                	add	a0,a0,a1
    80202700:	6108                	ld	a0,0(a0)
    80202702:	8502                	jr	a0
	...

0000000080202706 <.LBB0_3>:
    80202706:	f7043503          	ld	a0,-144(s0)
    8020270a:	00050503          	lb	a0,0(a0)
    8020270e:	f8a403a3          	sb	a0,-121(s0)
    80202712:	a069                	j	8020279c <.LBB0_7+0x16>

0000000080202714 <.LBB0_4>:
    80202714:	00005517          	auipc	a0,0x5
    80202718:	ed450593          	add	a1,a0,-300 # 802075e8 <.L__unnamed_1>
    8020271c:	f8840513          	add	a0,s0,-120
    80202720:	f6a43423          	sd	a0,-152(s0)
    80202724:	4605                	li	a2,1
    80202726:	00001097          	auipc	ra,0x1
    8020272a:	cde080e7          	jalr	-802(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    8020272e:	f6843503          	ld	a0,-152(s0)

0000000080202732 <.Lpcrel_hi2>:
    80202732:	00005597          	auipc	a1,0x5
    80202736:	ec658593          	add	a1,a1,-314 # 802075f8 <.L__unnamed_2>
    8020273a:	00003097          	auipc	ra,0x3
    8020273e:	df2080e7          	jalr	-526(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080202744 <.LBB0_5>:
    80202744:	f7043503          	ld	a0,-144(s0)
    80202748:	00050503          	lb	a0,0(a0)
    8020274c:	0230000f          	fence	r,rw
    80202750:	f8a403a3          	sb	a0,-121(s0)
    80202754:	a0a1                	j	8020279c <.LBB0_7+0x16>

0000000080202756 <.LBB0_6>:
    80202756:	00005517          	auipc	a0,0x5
    8020275a:	df250593          	add	a1,a0,-526 # 80207548 <.L__unnamed_3>
    8020275e:	fb840513          	add	a0,s0,-72
    80202762:	f6a43023          	sd	a0,-160(s0)
    80202766:	4605                	li	a2,1
    80202768:	00001097          	auipc	ra,0x1
    8020276c:	c9c080e7          	jalr	-868(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    80202770:	f6043503          	ld	a0,-160(s0)

0000000080202774 <.Lpcrel_hi4>:
    80202774:	00005597          	auipc	a1,0x5
    80202778:	e3458593          	add	a1,a1,-460 # 802075a8 <.L__unnamed_4>
    8020277c:	00003097          	auipc	ra,0x3
    80202780:	db0080e7          	jalr	-592(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080202786 <.LBB0_7>:
    80202786:	f7043503          	ld	a0,-144(s0)
    8020278a:	0330000f          	fence	rw,rw
    8020278e:	00050503          	lb	a0,0(a0)
    80202792:	0230000f          	fence	r,rw
    80202796:	f8a403a3          	sb	a0,-121(s0)
    8020279a:	a009                	j	8020279c <.LBB0_7+0x16>
    8020279c:	f8740503          	lb	a0,-121(s0)
    802027a0:	60ea                	ld	ra,152(sp)
    802027a2:	644a                	ld	s0,144(sp)
    802027a4:	610d                	add	sp,sp,160
    802027a6:	8082                	ret

00000000802027a8 <_ZN4core4sync6atomic23atomic_compare_exchange17h80444466ad3bca60E>:
    802027a8:	7111                	add	sp,sp,-256
    802027aa:	fd86                	sd	ra,248(sp)
    802027ac:	f9a2                	sd	s0,240(sp)
    802027ae:	0200                	add	s0,sp,256
    802027b0:	f4a43423          	sd	a0,-184(s0)
    802027b4:	87b2                	mv	a5,a2
    802027b6:	f4f43823          	sd	a5,-176(s0)
    802027ba:	87ae                	mv	a5,a1
    802027bc:	f4f43c23          	sd	a5,-168(s0)
    802027c0:	fea43023          	sd	a0,-32(s0)
    802027c4:	feb40523          	sb	a1,-22(s0)
    802027c8:	fec405a3          	sb	a2,-21(s0)
    802027cc:	fed40623          	sb	a3,-20(s0)
    802027d0:	fee406a3          	sb	a4,-19(s0)
    802027d4:	f6d40c23          	sb	a3,-136(s0)
    802027d8:	f6e40ca3          	sb	a4,-135(s0)
    802027dc:	f7844503          	lbu	a0,-136(s0)
    802027e0:	f6a43023          	sd	a0,-160(s0)
    802027e4:	f6043503          	ld	a0,-160(s0)
    802027e8:	050e                	sll	a0,a0,0x3

00000000802027ea <.Lpcrel_hi5>:
    802027ea:	00005597          	auipc	a1,0x5
    802027ee:	cfe58593          	add	a1,a1,-770 # 802074e8 <.LJTI1_0>
    802027f2:	952e                	add	a0,a0,a1
    802027f4:	6108                	ld	a0,0(a0)
    802027f6:	8502                	jr	a0
	...

00000000802027fa <.LBB1_3>:
    802027fa:	f7944503          	lbu	a0,-135(s0)
    802027fe:	f4a43023          	sd	a0,-192(s0)
    80202802:	52050763          	beqz	a0,80202d30 <.LBB1_15+0x49e>
    80202806:	a009                	j	80202808 <.LBB1_3+0xe>
    80202808:	f4043503          	ld	a0,-192(s0)
    8020280c:	4589                	li	a1,2
    8020280e:	56b50f63          	beq	a0,a1,80202d8c <.LBB1_15+0x4fa>
    80202812:	a009                	j	80202814 <.LBB1_3+0x1a>
    80202814:	f4043503          	ld	a0,-192(s0)
    80202818:	4591                	li	a1,4
    8020281a:	5cb50763          	beq	a0,a1,80202de8 <.LBB1_15+0x556>
    8020281e:	a861                	j	802028b6 <.LBB1_15+0x24>

0000000080202820 <.LBB1_6>:
    80202820:	f7944503          	lbu	a0,-135(s0)
    80202824:	f2a43c23          	sd	a0,-200(s0)
    80202828:	3e050a63          	beqz	a0,80202c1c <.LBB1_15+0x38a>
    8020282c:	a009                	j	8020282e <.LBB1_6+0xe>
    8020282e:	f3843503          	ld	a0,-200(s0)
    80202832:	4589                	li	a1,2
    80202834:	44b50263          	beq	a0,a1,80202c78 <.LBB1_15+0x3e6>
    80202838:	a009                	j	8020283a <.LBB1_6+0x1a>
    8020283a:	f3843503          	ld	a0,-200(s0)
    8020283e:	4591                	li	a1,4
    80202840:	48b50a63          	beq	a0,a1,80202cd4 <.LBB1_15+0x442>
    80202844:	a88d                	j	802028b6 <.LBB1_15+0x24>

0000000080202846 <.LBB1_9>:
    80202846:	f7944503          	lbu	a0,-135(s0)
    8020284a:	f2a43823          	sd	a0,-208(s0)
    8020284e:	2a050d63          	beqz	a0,80202b08 <.LBB1_15+0x276>
    80202852:	a009                	j	80202854 <.LBB1_9+0xe>
    80202854:	f3043503          	ld	a0,-208(s0)
    80202858:	4589                	li	a1,2
    8020285a:	30b50563          	beq	a0,a1,80202b64 <.LBB1_15+0x2d2>
    8020285e:	a009                	j	80202860 <.LBB1_9+0x1a>
    80202860:	f3043503          	ld	a0,-208(s0)
    80202864:	4591                	li	a1,4
    80202866:	34b50d63          	beq	a0,a1,80202bc0 <.LBB1_15+0x32e>
    8020286a:	a0b1                	j	802028b6 <.LBB1_15+0x24>

000000008020286c <.LBB1_12>:
    8020286c:	f7944503          	lbu	a0,-135(s0)
    80202870:	f2a43423          	sd	a0,-216(s0)
    80202874:	18050063          	beqz	a0,802029f4 <.LBB1_15+0x162>
    80202878:	a009                	j	8020287a <.LBB1_12+0xe>
    8020287a:	f2843503          	ld	a0,-216(s0)
    8020287e:	4589                	li	a1,2
    80202880:	1cb50863          	beq	a0,a1,80202a50 <.LBB1_15+0x1be>
    80202884:	a009                	j	80202886 <.LBB1_12+0x1a>
    80202886:	f2843503          	ld	a0,-216(s0)
    8020288a:	4591                	li	a1,4
    8020288c:	22b50063          	beq	a0,a1,80202aac <.LBB1_15+0x21a>
    80202890:	a01d                	j	802028b6 <.LBB1_15+0x24>

0000000080202892 <.LBB1_15>:
    80202892:	f7944503          	lbu	a0,-135(s0)
    80202896:	f2a43023          	sd	a0,-224(s0)
    8020289a:	c505                	beqz	a0,802028c2 <.LBB1_15+0x30>
    8020289c:	a009                	j	8020289e <.LBB1_15+0xc>
    8020289e:	f2043503          	ld	a0,-224(s0)
    802028a2:	4589                	li	a1,2
    802028a4:	06b50d63          	beq	a0,a1,8020291e <.LBB1_15+0x8c>
    802028a8:	a009                	j	802028aa <.LBB1_15+0x18>
    802028aa:	f2043503          	ld	a0,-224(s0)
    802028ae:	4591                	li	a1,4
    802028b0:	0cb50563          	beq	a0,a1,8020297a <.LBB1_15+0xe8>
    802028b4:	a009                	j	802028b6 <.LBB1_15+0x24>
    802028b6:	f7944503          	lbu	a0,-135(s0)
    802028ba:	4585                	li	a1,1
    802028bc:	58b50463          	beq	a0,a1,80202e44 <.Lpcrel_hi6>
    802028c0:	ab55                	j	80202e74 <.Lpcrel_hi8>
    802028c2:	f5043603          	ld	a2,-176(s0)
    802028c6:	f5843503          	ld	a0,-168(s0)
    802028ca:	f4843583          	ld	a1,-184(s0)
    802028ce:	ffc5f793          	and	a5,a1,-4
    802028d2:	0035959b          	sllw	a1,a1,0x3
    802028d6:	0ff00693          	li	a3,255
    802028da:	00b696bb          	sllw	a3,a3,a1
    802028de:	0ff57513          	zext.b	a0,a0
    802028e2:	00b5153b          	sllw	a0,a0,a1
    802028e6:	0ff67613          	zext.b	a2,a2
    802028ea:	00b6183b          	sllw	a6,a2,a1
    802028ee:	1607a62f          	lr.w.aqrl	a2,(a5)
    802028f2:	00d67733          	and	a4,a2,a3
    802028f6:	00a71963          	bne	a4,a0,80202908 <.LBB1_15+0x76>
    802028fa:	01064733          	xor	a4,a2,a6
    802028fe:	8f75                	and	a4,a4,a3
    80202900:	8f31                	xor	a4,a4,a2
    80202902:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202906:	f765                	bnez	a4,802028ee <.LBB1_15+0x5c>
    80202908:	00b655bb          	srlw	a1,a2,a1
    8020290c:	8e75                	and	a2,a2,a3
    8020290e:	8d31                	xor	a0,a0,a2
    80202910:	00153513          	seqz	a0,a0
    80202914:	f6b40823          	sb	a1,-144(s0)
    80202918:	f6a408a3          	sb	a0,-143(s0)
    8020291c:	a86d                	j	802029d6 <.LBB1_15+0x144>
    8020291e:	f5043603          	ld	a2,-176(s0)
    80202922:	f5843503          	ld	a0,-168(s0)
    80202926:	f4843583          	ld	a1,-184(s0)
    8020292a:	ffc5f793          	and	a5,a1,-4
    8020292e:	0035959b          	sllw	a1,a1,0x3
    80202932:	0ff00693          	li	a3,255
    80202936:	00b696bb          	sllw	a3,a3,a1
    8020293a:	0ff57513          	zext.b	a0,a0
    8020293e:	00b5153b          	sllw	a0,a0,a1
    80202942:	0ff67613          	zext.b	a2,a2
    80202946:	00b6183b          	sllw	a6,a2,a1
    8020294a:	1607a62f          	lr.w.aqrl	a2,(a5)
    8020294e:	00d67733          	and	a4,a2,a3
    80202952:	00a71963          	bne	a4,a0,80202964 <.LBB1_15+0xd2>
    80202956:	01064733          	xor	a4,a2,a6
    8020295a:	8f75                	and	a4,a4,a3
    8020295c:	8f31                	xor	a4,a4,a2
    8020295e:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202962:	f765                	bnez	a4,8020294a <.LBB1_15+0xb8>
    80202964:	00b655bb          	srlw	a1,a2,a1
    80202968:	8e75                	and	a2,a2,a3
    8020296a:	8d31                	xor	a0,a0,a2
    8020296c:	00153513          	seqz	a0,a0
    80202970:	f6b40823          	sb	a1,-144(s0)
    80202974:	f6a408a3          	sb	a0,-143(s0)
    80202978:	a8b9                	j	802029d6 <.LBB1_15+0x144>
    8020297a:	f5043603          	ld	a2,-176(s0)
    8020297e:	f5843503          	ld	a0,-168(s0)
    80202982:	f4843583          	ld	a1,-184(s0)
    80202986:	ffc5f793          	and	a5,a1,-4
    8020298a:	0035959b          	sllw	a1,a1,0x3
    8020298e:	0ff00693          	li	a3,255
    80202992:	00b696bb          	sllw	a3,a3,a1
    80202996:	0ff57513          	zext.b	a0,a0
    8020299a:	00b5153b          	sllw	a0,a0,a1
    8020299e:	0ff67613          	zext.b	a2,a2
    802029a2:	00b6183b          	sllw	a6,a2,a1
    802029a6:	1607a62f          	lr.w.aqrl	a2,(a5)
    802029aa:	00d67733          	and	a4,a2,a3
    802029ae:	00a71963          	bne	a4,a0,802029c0 <.LBB1_15+0x12e>
    802029b2:	01064733          	xor	a4,a2,a6
    802029b6:	8f75                	and	a4,a4,a3
    802029b8:	8f31                	xor	a4,a4,a2
    802029ba:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    802029be:	f765                	bnez	a4,802029a6 <.LBB1_15+0x114>
    802029c0:	00b655bb          	srlw	a1,a2,a1
    802029c4:	8e75                	and	a2,a2,a3
    802029c6:	8d31                	xor	a0,a0,a2
    802029c8:	00153513          	seqz	a0,a0
    802029cc:	f6b40823          	sb	a1,-144(s0)
    802029d0:	f6a408a3          	sb	a0,-143(s0)
    802029d4:	a009                	j	802029d6 <.LBB1_15+0x144>
    802029d6:	f7044503          	lbu	a0,-144(s0)
    802029da:	f0a43c23          	sd	a0,-232(s0)
    802029de:	fea40723          	sb	a0,-18(s0)
    802029e2:	f7144583          	lbu	a1,-143(s0)
    802029e6:	0015f513          	and	a0,a1,1
    802029ea:	feb407a3          	sb	a1,-17(s0)
    802029ee:	4c051363          	bnez	a0,80202eb4 <.Lpcrel_hi9+0x22>
    802029f2:	a94d                	j	80202ea4 <.Lpcrel_hi9+0x12>
    802029f4:	f5043603          	ld	a2,-176(s0)
    802029f8:	f5843503          	ld	a0,-168(s0)
    802029fc:	f4843583          	ld	a1,-184(s0)
    80202a00:	ffc5f793          	and	a5,a1,-4
    80202a04:	0035959b          	sllw	a1,a1,0x3
    80202a08:	0ff00693          	li	a3,255
    80202a0c:	00b696bb          	sllw	a3,a3,a1
    80202a10:	0ff57513          	zext.b	a0,a0
    80202a14:	00b5153b          	sllw	a0,a0,a1
    80202a18:	0ff67613          	zext.b	a2,a2
    80202a1c:	00b6183b          	sllw	a6,a2,a1
    80202a20:	1407a62f          	lr.w.aq	a2,(a5)
    80202a24:	00d67733          	and	a4,a2,a3
    80202a28:	00a71963          	bne	a4,a0,80202a3a <.LBB1_15+0x1a8>
    80202a2c:	01064733          	xor	a4,a2,a6
    80202a30:	8f75                	and	a4,a4,a3
    80202a32:	8f31                	xor	a4,a4,a2
    80202a34:	1ae7a72f          	sc.w.rl	a4,a4,(a5)
    80202a38:	f765                	bnez	a4,80202a20 <.LBB1_15+0x18e>
    80202a3a:	00b655bb          	srlw	a1,a2,a1
    80202a3e:	8e75                	and	a2,a2,a3
    80202a40:	8d31                	xor	a0,a0,a2
    80202a42:	00153513          	seqz	a0,a0
    80202a46:	f6b40823          	sb	a1,-144(s0)
    80202a4a:	f6a408a3          	sb	a0,-143(s0)
    80202a4e:	b761                	j	802029d6 <.LBB1_15+0x144>
    80202a50:	f5043603          	ld	a2,-176(s0)
    80202a54:	f5843503          	ld	a0,-168(s0)
    80202a58:	f4843583          	ld	a1,-184(s0)
    80202a5c:	ffc5f793          	and	a5,a1,-4
    80202a60:	0035959b          	sllw	a1,a1,0x3
    80202a64:	0ff00693          	li	a3,255
    80202a68:	00b696bb          	sllw	a3,a3,a1
    80202a6c:	0ff57513          	zext.b	a0,a0
    80202a70:	00b5153b          	sllw	a0,a0,a1
    80202a74:	0ff67613          	zext.b	a2,a2
    80202a78:	00b6183b          	sllw	a6,a2,a1
    80202a7c:	1407a62f          	lr.w.aq	a2,(a5)
    80202a80:	00d67733          	and	a4,a2,a3
    80202a84:	00a71963          	bne	a4,a0,80202a96 <.LBB1_15+0x204>
    80202a88:	01064733          	xor	a4,a2,a6
    80202a8c:	8f75                	and	a4,a4,a3
    80202a8e:	8f31                	xor	a4,a4,a2
    80202a90:	1ae7a72f          	sc.w.rl	a4,a4,(a5)
    80202a94:	f765                	bnez	a4,80202a7c <.LBB1_15+0x1ea>
    80202a96:	00b655bb          	srlw	a1,a2,a1
    80202a9a:	8e75                	and	a2,a2,a3
    80202a9c:	8d31                	xor	a0,a0,a2
    80202a9e:	00153513          	seqz	a0,a0
    80202aa2:	f6b40823          	sb	a1,-144(s0)
    80202aa6:	f6a408a3          	sb	a0,-143(s0)
    80202aaa:	b735                	j	802029d6 <.LBB1_15+0x144>
    80202aac:	f5043603          	ld	a2,-176(s0)
    80202ab0:	f5843503          	ld	a0,-168(s0)
    80202ab4:	f4843583          	ld	a1,-184(s0)
    80202ab8:	ffc5f793          	and	a5,a1,-4
    80202abc:	0035959b          	sllw	a1,a1,0x3
    80202ac0:	0ff00693          	li	a3,255
    80202ac4:	00b696bb          	sllw	a3,a3,a1
    80202ac8:	0ff57513          	zext.b	a0,a0
    80202acc:	00b5153b          	sllw	a0,a0,a1
    80202ad0:	0ff67613          	zext.b	a2,a2
    80202ad4:	00b6183b          	sllw	a6,a2,a1
    80202ad8:	1607a62f          	lr.w.aqrl	a2,(a5)
    80202adc:	00d67733          	and	a4,a2,a3
    80202ae0:	00a71963          	bne	a4,a0,80202af2 <.LBB1_15+0x260>
    80202ae4:	01064733          	xor	a4,a2,a6
    80202ae8:	8f75                	and	a4,a4,a3
    80202aea:	8f31                	xor	a4,a4,a2
    80202aec:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202af0:	f765                	bnez	a4,80202ad8 <.LBB1_15+0x246>
    80202af2:	00b655bb          	srlw	a1,a2,a1
    80202af6:	8e75                	and	a2,a2,a3
    80202af8:	8d31                	xor	a0,a0,a2
    80202afa:	00153513          	seqz	a0,a0
    80202afe:	f6b40823          	sb	a1,-144(s0)
    80202b02:	f6a408a3          	sb	a0,-143(s0)
    80202b06:	bdc1                	j	802029d6 <.LBB1_15+0x144>
    80202b08:	f5043603          	ld	a2,-176(s0)
    80202b0c:	f5843503          	ld	a0,-168(s0)
    80202b10:	f4843583          	ld	a1,-184(s0)
    80202b14:	ffc5f793          	and	a5,a1,-4
    80202b18:	0035959b          	sllw	a1,a1,0x3
    80202b1c:	0ff00693          	li	a3,255
    80202b20:	00b696bb          	sllw	a3,a3,a1
    80202b24:	0ff57513          	zext.b	a0,a0
    80202b28:	00b5153b          	sllw	a0,a0,a1
    80202b2c:	0ff67613          	zext.b	a2,a2
    80202b30:	00b6183b          	sllw	a6,a2,a1
    80202b34:	1407a62f          	lr.w.aq	a2,(a5)
    80202b38:	00d67733          	and	a4,a2,a3
    80202b3c:	00a71963          	bne	a4,a0,80202b4e <.LBB1_15+0x2bc>
    80202b40:	01064733          	xor	a4,a2,a6
    80202b44:	8f75                	and	a4,a4,a3
    80202b46:	8f31                	xor	a4,a4,a2
    80202b48:	18e7a72f          	sc.w	a4,a4,(a5)
    80202b4c:	f765                	bnez	a4,80202b34 <.LBB1_15+0x2a2>
    80202b4e:	00b655bb          	srlw	a1,a2,a1
    80202b52:	8e75                	and	a2,a2,a3
    80202b54:	8d31                	xor	a0,a0,a2
    80202b56:	00153513          	seqz	a0,a0
    80202b5a:	f6b40823          	sb	a1,-144(s0)
    80202b5e:	f6a408a3          	sb	a0,-143(s0)
    80202b62:	bd95                	j	802029d6 <.LBB1_15+0x144>
    80202b64:	f5043603          	ld	a2,-176(s0)
    80202b68:	f5843503          	ld	a0,-168(s0)
    80202b6c:	f4843583          	ld	a1,-184(s0)
    80202b70:	ffc5f793          	and	a5,a1,-4
    80202b74:	0035959b          	sllw	a1,a1,0x3
    80202b78:	0ff00693          	li	a3,255
    80202b7c:	00b696bb          	sllw	a3,a3,a1
    80202b80:	0ff57513          	zext.b	a0,a0
    80202b84:	00b5153b          	sllw	a0,a0,a1
    80202b88:	0ff67613          	zext.b	a2,a2
    80202b8c:	00b6183b          	sllw	a6,a2,a1
    80202b90:	1407a62f          	lr.w.aq	a2,(a5)
    80202b94:	00d67733          	and	a4,a2,a3
    80202b98:	00a71963          	bne	a4,a0,80202baa <.LBB1_15+0x318>
    80202b9c:	01064733          	xor	a4,a2,a6
    80202ba0:	8f75                	and	a4,a4,a3
    80202ba2:	8f31                	xor	a4,a4,a2
    80202ba4:	18e7a72f          	sc.w	a4,a4,(a5)
    80202ba8:	f765                	bnez	a4,80202b90 <.LBB1_15+0x2fe>
    80202baa:	00b655bb          	srlw	a1,a2,a1
    80202bae:	8e75                	and	a2,a2,a3
    80202bb0:	8d31                	xor	a0,a0,a2
    80202bb2:	00153513          	seqz	a0,a0
    80202bb6:	f6b40823          	sb	a1,-144(s0)
    80202bba:	f6a408a3          	sb	a0,-143(s0)
    80202bbe:	bd21                	j	802029d6 <.LBB1_15+0x144>
    80202bc0:	f5043603          	ld	a2,-176(s0)
    80202bc4:	f5843503          	ld	a0,-168(s0)
    80202bc8:	f4843583          	ld	a1,-184(s0)
    80202bcc:	ffc5f793          	and	a5,a1,-4
    80202bd0:	0035959b          	sllw	a1,a1,0x3
    80202bd4:	0ff00693          	li	a3,255
    80202bd8:	00b696bb          	sllw	a3,a3,a1
    80202bdc:	0ff57513          	zext.b	a0,a0
    80202be0:	00b5153b          	sllw	a0,a0,a1
    80202be4:	0ff67613          	zext.b	a2,a2
    80202be8:	00b6183b          	sllw	a6,a2,a1
    80202bec:	1607a62f          	lr.w.aqrl	a2,(a5)
    80202bf0:	00d67733          	and	a4,a2,a3
    80202bf4:	00a71963          	bne	a4,a0,80202c06 <.LBB1_15+0x374>
    80202bf8:	01064733          	xor	a4,a2,a6
    80202bfc:	8f75                	and	a4,a4,a3
    80202bfe:	8f31                	xor	a4,a4,a2
    80202c00:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202c04:	f765                	bnez	a4,80202bec <.LBB1_15+0x35a>
    80202c06:	00b655bb          	srlw	a1,a2,a1
    80202c0a:	8e75                	and	a2,a2,a3
    80202c0c:	8d31                	xor	a0,a0,a2
    80202c0e:	00153513          	seqz	a0,a0
    80202c12:	f6b40823          	sb	a1,-144(s0)
    80202c16:	f6a408a3          	sb	a0,-143(s0)
    80202c1a:	bb75                	j	802029d6 <.LBB1_15+0x144>
    80202c1c:	f5043603          	ld	a2,-176(s0)
    80202c20:	f5843503          	ld	a0,-168(s0)
    80202c24:	f4843583          	ld	a1,-184(s0)
    80202c28:	ffc5f793          	and	a5,a1,-4
    80202c2c:	0035959b          	sllw	a1,a1,0x3
    80202c30:	0ff00693          	li	a3,255
    80202c34:	00b696bb          	sllw	a3,a3,a1
    80202c38:	0ff57513          	zext.b	a0,a0
    80202c3c:	00b5153b          	sllw	a0,a0,a1
    80202c40:	0ff67613          	zext.b	a2,a2
    80202c44:	00b6183b          	sllw	a6,a2,a1
    80202c48:	1007a62f          	lr.w	a2,(a5)
    80202c4c:	00d67733          	and	a4,a2,a3
    80202c50:	00a71963          	bne	a4,a0,80202c62 <.LBB1_15+0x3d0>
    80202c54:	01064733          	xor	a4,a2,a6
    80202c58:	8f75                	and	a4,a4,a3
    80202c5a:	8f31                	xor	a4,a4,a2
    80202c5c:	1ae7a72f          	sc.w.rl	a4,a4,(a5)
    80202c60:	f765                	bnez	a4,80202c48 <.LBB1_15+0x3b6>
    80202c62:	00b655bb          	srlw	a1,a2,a1
    80202c66:	8e75                	and	a2,a2,a3
    80202c68:	8d31                	xor	a0,a0,a2
    80202c6a:	00153513          	seqz	a0,a0
    80202c6e:	f6b40823          	sb	a1,-144(s0)
    80202c72:	f6a408a3          	sb	a0,-143(s0)
    80202c76:	b385                	j	802029d6 <.LBB1_15+0x144>
    80202c78:	f5043603          	ld	a2,-176(s0)
    80202c7c:	f5843503          	ld	a0,-168(s0)
    80202c80:	f4843583          	ld	a1,-184(s0)
    80202c84:	ffc5f793          	and	a5,a1,-4
    80202c88:	0035959b          	sllw	a1,a1,0x3
    80202c8c:	0ff00693          	li	a3,255
    80202c90:	00b696bb          	sllw	a3,a3,a1
    80202c94:	0ff57513          	zext.b	a0,a0
    80202c98:	00b5153b          	sllw	a0,a0,a1
    80202c9c:	0ff67613          	zext.b	a2,a2
    80202ca0:	00b6183b          	sllw	a6,a2,a1
    80202ca4:	1407a62f          	lr.w.aq	a2,(a5)
    80202ca8:	00d67733          	and	a4,a2,a3
    80202cac:	00a71963          	bne	a4,a0,80202cbe <.LBB1_15+0x42c>
    80202cb0:	01064733          	xor	a4,a2,a6
    80202cb4:	8f75                	and	a4,a4,a3
    80202cb6:	8f31                	xor	a4,a4,a2
    80202cb8:	1ae7a72f          	sc.w.rl	a4,a4,(a5)
    80202cbc:	f765                	bnez	a4,80202ca4 <.LBB1_15+0x412>
    80202cbe:	00b655bb          	srlw	a1,a2,a1
    80202cc2:	8e75                	and	a2,a2,a3
    80202cc4:	8d31                	xor	a0,a0,a2
    80202cc6:	00153513          	seqz	a0,a0
    80202cca:	f6b40823          	sb	a1,-144(s0)
    80202cce:	f6a408a3          	sb	a0,-143(s0)
    80202cd2:	b311                	j	802029d6 <.LBB1_15+0x144>
    80202cd4:	f5043603          	ld	a2,-176(s0)
    80202cd8:	f5843503          	ld	a0,-168(s0)
    80202cdc:	f4843583          	ld	a1,-184(s0)
    80202ce0:	ffc5f793          	and	a5,a1,-4
    80202ce4:	0035959b          	sllw	a1,a1,0x3
    80202ce8:	0ff00693          	li	a3,255
    80202cec:	00b696bb          	sllw	a3,a3,a1
    80202cf0:	0ff57513          	zext.b	a0,a0
    80202cf4:	00b5153b          	sllw	a0,a0,a1
    80202cf8:	0ff67613          	zext.b	a2,a2
    80202cfc:	00b6183b          	sllw	a6,a2,a1
    80202d00:	1607a62f          	lr.w.aqrl	a2,(a5)
    80202d04:	00d67733          	and	a4,a2,a3
    80202d08:	00a71963          	bne	a4,a0,80202d1a <.LBB1_15+0x488>
    80202d0c:	01064733          	xor	a4,a2,a6
    80202d10:	8f75                	and	a4,a4,a3
    80202d12:	8f31                	xor	a4,a4,a2
    80202d14:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202d18:	f765                	bnez	a4,80202d00 <.LBB1_15+0x46e>
    80202d1a:	00b655bb          	srlw	a1,a2,a1
    80202d1e:	8e75                	and	a2,a2,a3
    80202d20:	8d31                	xor	a0,a0,a2
    80202d22:	00153513          	seqz	a0,a0
    80202d26:	f6b40823          	sb	a1,-144(s0)
    80202d2a:	f6a408a3          	sb	a0,-143(s0)
    80202d2e:	b165                	j	802029d6 <.LBB1_15+0x144>
    80202d30:	f5043603          	ld	a2,-176(s0)
    80202d34:	f5843503          	ld	a0,-168(s0)
    80202d38:	f4843583          	ld	a1,-184(s0)
    80202d3c:	ffc5f793          	and	a5,a1,-4
    80202d40:	0035959b          	sllw	a1,a1,0x3
    80202d44:	0ff00693          	li	a3,255
    80202d48:	00b696bb          	sllw	a3,a3,a1
    80202d4c:	0ff57513          	zext.b	a0,a0
    80202d50:	00b5153b          	sllw	a0,a0,a1
    80202d54:	0ff67613          	zext.b	a2,a2
    80202d58:	00b6183b          	sllw	a6,a2,a1
    80202d5c:	1007a62f          	lr.w	a2,(a5)
    80202d60:	00d67733          	and	a4,a2,a3
    80202d64:	00a71963          	bne	a4,a0,80202d76 <.LBB1_15+0x4e4>
    80202d68:	01064733          	xor	a4,a2,a6
    80202d6c:	8f75                	and	a4,a4,a3
    80202d6e:	8f31                	xor	a4,a4,a2
    80202d70:	18e7a72f          	sc.w	a4,a4,(a5)
    80202d74:	f765                	bnez	a4,80202d5c <.LBB1_15+0x4ca>
    80202d76:	00b655bb          	srlw	a1,a2,a1
    80202d7a:	8e75                	and	a2,a2,a3
    80202d7c:	8d31                	xor	a0,a0,a2
    80202d7e:	00153513          	seqz	a0,a0
    80202d82:	f6b40823          	sb	a1,-144(s0)
    80202d86:	f6a408a3          	sb	a0,-143(s0)
    80202d8a:	b1b1                	j	802029d6 <.LBB1_15+0x144>
    80202d8c:	f5043603          	ld	a2,-176(s0)
    80202d90:	f5843503          	ld	a0,-168(s0)
    80202d94:	f4843583          	ld	a1,-184(s0)
    80202d98:	ffc5f793          	and	a5,a1,-4
    80202d9c:	0035959b          	sllw	a1,a1,0x3
    80202da0:	0ff00693          	li	a3,255
    80202da4:	00b696bb          	sllw	a3,a3,a1
    80202da8:	0ff57513          	zext.b	a0,a0
    80202dac:	00b5153b          	sllw	a0,a0,a1
    80202db0:	0ff67613          	zext.b	a2,a2
    80202db4:	00b6183b          	sllw	a6,a2,a1
    80202db8:	1407a62f          	lr.w.aq	a2,(a5)
    80202dbc:	00d67733          	and	a4,a2,a3
    80202dc0:	00a71963          	bne	a4,a0,80202dd2 <.LBB1_15+0x540>
    80202dc4:	01064733          	xor	a4,a2,a6
    80202dc8:	8f75                	and	a4,a4,a3
    80202dca:	8f31                	xor	a4,a4,a2
    80202dcc:	18e7a72f          	sc.w	a4,a4,(a5)
    80202dd0:	f765                	bnez	a4,80202db8 <.LBB1_15+0x526>
    80202dd2:	00b655bb          	srlw	a1,a2,a1
    80202dd6:	8e75                	and	a2,a2,a3
    80202dd8:	8d31                	xor	a0,a0,a2
    80202dda:	00153513          	seqz	a0,a0
    80202dde:	f6b40823          	sb	a1,-144(s0)
    80202de2:	f6a408a3          	sb	a0,-143(s0)
    80202de6:	bec5                	j	802029d6 <.LBB1_15+0x144>
    80202de8:	f5043603          	ld	a2,-176(s0)
    80202dec:	f5843503          	ld	a0,-168(s0)
    80202df0:	f4843583          	ld	a1,-184(s0)
    80202df4:	ffc5f793          	and	a5,a1,-4
    80202df8:	0035959b          	sllw	a1,a1,0x3
    80202dfc:	0ff00693          	li	a3,255
    80202e00:	00b696bb          	sllw	a3,a3,a1
    80202e04:	0ff57513          	zext.b	a0,a0
    80202e08:	00b5153b          	sllw	a0,a0,a1
    80202e0c:	0ff67613          	zext.b	a2,a2
    80202e10:	00b6183b          	sllw	a6,a2,a1
    80202e14:	1607a62f          	lr.w.aqrl	a2,(a5)
    80202e18:	00d67733          	and	a4,a2,a3
    80202e1c:	00a71963          	bne	a4,a0,80202e2e <.LBB1_15+0x59c>
    80202e20:	01064733          	xor	a4,a2,a6
    80202e24:	8f75                	and	a4,a4,a3
    80202e26:	8f31                	xor	a4,a4,a2
    80202e28:	1ee7a72f          	sc.w.aqrl	a4,a4,(a5)
    80202e2c:	f765                	bnez	a4,80202e14 <.LBB1_15+0x582>
    80202e2e:	00b655bb          	srlw	a1,a2,a1
    80202e32:	8e75                	and	a2,a2,a3
    80202e34:	8d31                	xor	a0,a0,a2
    80202e36:	00153513          	seqz	a0,a0
    80202e3a:	f6b40823          	sb	a1,-144(s0)
    80202e3e:	f6a408a3          	sb	a0,-143(s0)
    80202e42:	be51                	j	802029d6 <.LBB1_15+0x144>

0000000080202e44 <.Lpcrel_hi6>:
    80202e44:	00005517          	auipc	a0,0x5
    80202e48:	86c50593          	add	a1,a0,-1940 # 802076b0 <.L__unnamed_5>
    80202e4c:	fb040513          	add	a0,s0,-80
    80202e50:	f0a43823          	sd	a0,-240(s0)
    80202e54:	4605                	li	a2,1
    80202e56:	00000097          	auipc	ra,0x0
    80202e5a:	5ae080e7          	jalr	1454(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    80202e5e:	f1043503          	ld	a0,-240(s0)

0000000080202e62 <.Lpcrel_hi7>:
    80202e62:	00005597          	auipc	a1,0x5
    80202e66:	85e58593          	add	a1,a1,-1954 # 802076c0 <.L__unnamed_6>
    80202e6a:	00002097          	auipc	ra,0x2
    80202e6e:	6c2080e7          	jalr	1730(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080202e74 <.Lpcrel_hi8>:
    80202e74:	00004517          	auipc	a0,0x4
    80202e78:	7dc50593          	add	a1,a0,2012 # 80207650 <.L__unnamed_7>
    80202e7c:	f8040513          	add	a0,s0,-128
    80202e80:	f0a43423          	sd	a0,-248(s0)
    80202e84:	4605                	li	a2,1
    80202e86:	00000097          	auipc	ra,0x0
    80202e8a:	57e080e7          	jalr	1406(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    80202e8e:	f0843503          	ld	a0,-248(s0)

0000000080202e92 <.Lpcrel_hi9>:
    80202e92:	00004597          	auipc	a1,0x4
    80202e96:	7ce58593          	add	a1,a1,1998 # 80207660 <.L__unnamed_8>
    80202e9a:	00002097          	auipc	ra,0x2
    80202e9e:	692080e7          	jalr	1682(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
    80202ea2:	0000                	unimp
    80202ea4:	f1843503          	ld	a0,-232(s0)
    80202ea8:	f6a404a3          	sb	a0,-151(s0)
    80202eac:	4505                	li	a0,1
    80202eae:	f6a40423          	sb	a0,-152(s0)
    80202eb2:	a809                	j	80202ec4 <.Lpcrel_hi9+0x32>
    80202eb4:	f1843503          	ld	a0,-232(s0)
    80202eb8:	f6a404a3          	sb	a0,-151(s0)
    80202ebc:	4501                	li	a0,0
    80202ebe:	f6a40423          	sb	a0,-152(s0)
    80202ec2:	a009                	j	80202ec4 <.Lpcrel_hi9+0x32>
    80202ec4:	f6844503          	lbu	a0,-152(s0)
    80202ec8:	f6940583          	lb	a1,-151(s0)
    80202ecc:	70ee                	ld	ra,248(sp)
    80202ece:	744e                	ld	s0,240(sp)
    80202ed0:	6111                	add	sp,sp,256
    80202ed2:	8082                	ret

0000000080202ed4 <_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17hcd0dc45849769110E>:
    80202ed4:	712d                	add	sp,sp,-288
    80202ed6:	ee06                	sd	ra,280(sp)
    80202ed8:	ea22                	sd	s0,272(sp)
    80202eda:	e626                	sd	s1,264(sp)
    80202edc:	e24a                	sd	s2,256(sp)
    80202ede:	fdce                	sd	s3,248(sp)
    80202ee0:	f9d2                	sd	s4,240(sp)
    80202ee2:	f5d6                	sd	s5,232(sp)
    80202ee4:	f1da                	sd	s6,224(sp)
    80202ee6:	edde                	sd	s7,216(sp)
    80202ee8:	e9e2                	sd	s8,208(sp)
    80202eea:	e5e6                	sd	s9,200(sp)
    80202eec:	e1ea                	sd	s10,192(sp)
    80202eee:	fd6e                	sd	s11,184(sp)
    80202ef0:	1200                	add	s0,sp,288
    80202ef2:	f4a43823          	sd	a0,-176(s0)
    80202ef6:	00001097          	auipc	ra,0x1
    80202efa:	e48080e7          	jalr	-440(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202efe:	f6a43023          	sd	a0,-160(s0)
    80202f02:	00001097          	auipc	ra,0x1
    80202f06:	e3c080e7          	jalr	-452(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f0a:	f6a43423          	sd	a0,-152(s0)
    80202f0e:	00001097          	auipc	ra,0x1
    80202f12:	e30080e7          	jalr	-464(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f16:	f6a43823          	sd	a0,-144(s0)
    80202f1a:	00001097          	auipc	ra,0x1
    80202f1e:	e24080e7          	jalr	-476(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f22:	f6a43c23          	sd	a0,-136(s0)
    80202f26:	00001097          	auipc	ra,0x1
    80202f2a:	e18080e7          	jalr	-488(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f2e:	f8a43023          	sd	a0,-128(s0)
    80202f32:	00001097          	auipc	ra,0x1
    80202f36:	e0c080e7          	jalr	-500(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f3a:	f8a43423          	sd	a0,-120(s0)
    80202f3e:	00001097          	auipc	ra,0x1
    80202f42:	e00080e7          	jalr	-512(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f46:	f4a43c23          	sd	a0,-168(s0)
    80202f4a:	00001097          	auipc	ra,0x1
    80202f4e:	df4080e7          	jalr	-524(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f52:	8daa                	mv	s11,a0
    80202f54:	00001097          	auipc	ra,0x1
    80202f58:	dea080e7          	jalr	-534(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f5c:	8d2a                	mv	s10,a0
    80202f5e:	00001097          	auipc	ra,0x1
    80202f62:	de0080e7          	jalr	-544(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f66:	8caa                	mv	s9,a0
    80202f68:	00001097          	auipc	ra,0x1
    80202f6c:	dd6080e7          	jalr	-554(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f70:	8c2a                	mv	s8,a0
    80202f72:	00001097          	auipc	ra,0x1
    80202f76:	dcc080e7          	jalr	-564(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f7a:	8baa                	mv	s7,a0
    80202f7c:	00001097          	auipc	ra,0x1
    80202f80:	dc2080e7          	jalr	-574(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f84:	8b2a                	mv	s6,a0
    80202f86:	00001097          	auipc	ra,0x1
    80202f8a:	db8080e7          	jalr	-584(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f8e:	8aaa                	mv	s5,a0
    80202f90:	00001097          	auipc	ra,0x1
    80202f94:	dae080e7          	jalr	-594(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202f98:	8a2a                	mv	s4,a0
    80202f9a:	00001097          	auipc	ra,0x1
    80202f9e:	da4080e7          	jalr	-604(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fa2:	89aa                	mv	s3,a0
    80202fa4:	00001097          	auipc	ra,0x1
    80202fa8:	d9a080e7          	jalr	-614(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fac:	892a                	mv	s2,a0
    80202fae:	00001097          	auipc	ra,0x1
    80202fb2:	d90080e7          	jalr	-624(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fb6:	84aa                	mv	s1,a0
    80202fb8:	00001097          	auipc	ra,0x1
    80202fbc:	d86080e7          	jalr	-634(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fc0:	eea43423          	sd	a0,-280(s0)
    80202fc4:	00001097          	auipc	ra,0x1
    80202fc8:	d7a080e7          	jalr	-646(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fcc:	eea43823          	sd	a0,-272(s0)
    80202fd0:	00001097          	auipc	ra,0x1
    80202fd4:	d6e080e7          	jalr	-658(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fd8:	eea43c23          	sd	a0,-264(s0)
    80202fdc:	00001097          	auipc	ra,0x1
    80202fe0:	d62080e7          	jalr	-670(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202fe4:	f0a43023          	sd	a0,-256(s0)
    80202fe8:	00001097          	auipc	ra,0x1
    80202fec:	d56080e7          	jalr	-682(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202ff0:	f0a43423          	sd	a0,-248(s0)
    80202ff4:	00001097          	auipc	ra,0x1
    80202ff8:	d4a080e7          	jalr	-694(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80202ffc:	f0a43823          	sd	a0,-240(s0)
    80203000:	00001097          	auipc	ra,0x1
    80203004:	d3e080e7          	jalr	-706(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203008:	f0a43c23          	sd	a0,-232(s0)
    8020300c:	00001097          	auipc	ra,0x1
    80203010:	d32080e7          	jalr	-718(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203014:	f2a43023          	sd	a0,-224(s0)
    80203018:	00001097          	auipc	ra,0x1
    8020301c:	d26080e7          	jalr	-730(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203020:	f2a43423          	sd	a0,-216(s0)
    80203024:	00001097          	auipc	ra,0x1
    80203028:	d1a080e7          	jalr	-742(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020302c:	f2a43823          	sd	a0,-208(s0)
    80203030:	00001097          	auipc	ra,0x1
    80203034:	d0e080e7          	jalr	-754(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203038:	f2a43c23          	sd	a0,-200(s0)
    8020303c:	00001097          	auipc	ra,0x1
    80203040:	d02080e7          	jalr	-766(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203044:	f4a43023          	sd	a0,-192(s0)
    80203048:	00001097          	auipc	ra,0x1
    8020304c:	cf6080e7          	jalr	-778(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80203050:	f4a43423          	sd	a0,-184(s0)
    80203054:	00001097          	auipc	ra,0x1
    80203058:	cea080e7          	jalr	-790(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020305c:	ee843f83          	ld	t6,-280(s0)
    80203060:	ef043f03          	ld	t5,-272(s0)
    80203064:	ef843e83          	ld	t4,-264(s0)
    80203068:	f0043e03          	ld	t3,-256(s0)
    8020306c:	f0843383          	ld	t2,-248(s0)
    80203070:	f1043303          	ld	t1,-240(s0)
    80203074:	f1843283          	ld	t0,-232(s0)
    80203078:	f2043883          	ld	a7,-224(s0)
    8020307c:	f2843803          	ld	a6,-216(s0)
    80203080:	f3043783          	ld	a5,-208(s0)
    80203084:	f3843703          	ld	a4,-200(s0)
    80203088:	f4043683          	ld	a3,-192(s0)
    8020308c:	f4843603          	ld	a2,-184(s0)
    80203090:	f5043583          	ld	a1,-176(s0)
    80203094:	f5843083          	ld	ra,-168(s0)
    80203098:	f8a43823          	sd	a0,-112(s0)
    8020309c:	f6043503          	ld	a0,-160(s0)
    802030a0:	e188                	sd	a0,0(a1)
    802030a2:	f6843503          	ld	a0,-152(s0)
    802030a6:	e588                	sd	a0,8(a1)
    802030a8:	f7043503          	ld	a0,-144(s0)
    802030ac:	e988                	sd	a0,16(a1)
    802030ae:	f7843503          	ld	a0,-136(s0)
    802030b2:	ed88                	sd	a0,24(a1)
    802030b4:	f8043503          	ld	a0,-128(s0)
    802030b8:	f188                	sd	a0,32(a1)
    802030ba:	f8843503          	ld	a0,-120(s0)
    802030be:	f588                	sd	a0,40(a1)
    802030c0:	f9043503          	ld	a0,-112(s0)
    802030c4:	0215b823          	sd	ra,48(a1)
    802030c8:	03b5bc23          	sd	s11,56(a1)
    802030cc:	05a5b023          	sd	s10,64(a1)
    802030d0:	0595b423          	sd	s9,72(a1)
    802030d4:	0585b823          	sd	s8,80(a1)
    802030d8:	0575bc23          	sd	s7,88(a1)
    802030dc:	0765b023          	sd	s6,96(a1)
    802030e0:	0755b423          	sd	s5,104(a1)
    802030e4:	0745b823          	sd	s4,112(a1)
    802030e8:	0735bc23          	sd	s3,120(a1)
    802030ec:	0925b023          	sd	s2,128(a1)
    802030f0:	e5c4                	sd	s1,136(a1)
    802030f2:	09f5b823          	sd	t6,144(a1)
    802030f6:	09e5bc23          	sd	t5,152(a1)
    802030fa:	0bd5b023          	sd	t4,160(a1)
    802030fe:	0bc5b423          	sd	t3,168(a1)
    80203102:	0a75b823          	sd	t2,176(a1)
    80203106:	0a65bc23          	sd	t1,184(a1)
    8020310a:	0c55b023          	sd	t0,192(a1)
    8020310e:	0d15b423          	sd	a7,200(a1)
    80203112:	0d05b823          	sd	a6,208(a1)
    80203116:	edfc                	sd	a5,216(a1)
    80203118:	f1f8                	sd	a4,224(a1)
    8020311a:	f5f4                	sd	a3,232(a1)
    8020311c:	f9f0                	sd	a2,240(a1)
    8020311e:	fde8                	sd	a0,248(a1)
    80203120:	60f2                	ld	ra,280(sp)
    80203122:	6452                	ld	s0,272(sp)
    80203124:	64b2                	ld	s1,264(sp)
    80203126:	6912                	ld	s2,256(sp)
    80203128:	79ee                	ld	s3,248(sp)
    8020312a:	7a4e                	ld	s4,240(sp)
    8020312c:	7aae                	ld	s5,232(sp)
    8020312e:	7b0e                	ld	s6,224(sp)
    80203130:	6bee                	ld	s7,216(sp)
    80203132:	6c4e                	ld	s8,208(sp)
    80203134:	6cae                	ld	s9,200(sp)
    80203136:	6d0e                	ld	s10,192(sp)
    80203138:	7dea                	ld	s11,184(sp)
    8020313a:	6115                	add	sp,sp,288
    8020313c:	8082                	ret

000000008020313e <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h09e42b22946a84abE>:
    8020313e:	1101                	add	sp,sp,-32
    80203140:	ec06                	sd	ra,24(sp)
    80203142:	e822                	sd	s0,16(sp)
    80203144:	1000                	add	s0,sp,32
    80203146:	fea43023          	sd	a0,-32(s0)
    8020314a:	feb43423          	sd	a1,-24(s0)
    8020314e:	6108                	ld	a0,0(a0)
    80203150:	00003097          	auipc	ra,0x3
    80203154:	96a080e7          	jalr	-1686(ra) # 80205aba <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h2dda9a3aab941d66E>
    80203158:	60e2                	ld	ra,24(sp)
    8020315a:	6442                	ld	s0,16(sp)
    8020315c:	6105                	add	sp,sp,32
    8020315e:	8082                	ret

0000000080203160 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h254fb01b413590a2E>:
    80203160:	1101                	add	sp,sp,-32
    80203162:	ec06                	sd	ra,24(sp)
    80203164:	e822                	sd	s0,16(sp)
    80203166:	1000                	add	s0,sp,32
    80203168:	862e                	mv	a2,a1
    8020316a:	85aa                	mv	a1,a0
    8020316c:	feb43023          	sd	a1,-32(s0)
    80203170:	fec43423          	sd	a2,-24(s0)
    80203174:	6188                	ld	a0,0(a1)
    80203176:	658c                	ld	a1,8(a1)
    80203178:	00003097          	auipc	ra,0x3
    8020317c:	032080e7          	jalr	50(ra) # 802061aa <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h2440eaa81e730c67E>
    80203180:	60e2                	ld	ra,24(sp)
    80203182:	6442                	ld	s0,16(sp)
    80203184:	6105                	add	sp,sp,32
    80203186:	8082                	ret

0000000080203188 <_ZN4core3fmt10ArgumentV111new_display17h04c26f2958d6c289E>:
    80203188:	7179                	add	sp,sp,-48
    8020318a:	f406                	sd	ra,40(sp)
    8020318c:	f022                	sd	s0,32(sp)
    8020318e:	1800                	add	s0,sp,48
    80203190:	85aa                	mv	a1,a0
    80203192:	feb43023          	sd	a1,-32(s0)

0000000080203196 <.Lpcrel_hi0>:
    80203196:	00000517          	auipc	a0,0x0
    8020319a:	fca50513          	add	a0,a0,-54 # 80203160 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h254fb01b413590a2E>
    8020319e:	fea43423          	sd	a0,-24(s0)
    802031a2:	fcb43823          	sd	a1,-48(s0)
    802031a6:	fca43c23          	sd	a0,-40(s0)
    802031aa:	fd043503          	ld	a0,-48(s0)
    802031ae:	fd843583          	ld	a1,-40(s0)
    802031b2:	70a2                	ld	ra,40(sp)
    802031b4:	7402                	ld	s0,32(sp)
    802031b6:	6145                	add	sp,sp,48
    802031b8:	8082                	ret

00000000802031ba <_ZN4core3fmt10ArgumentV111new_display17ha5924b1057f0b37fE>:
    802031ba:	7179                	add	sp,sp,-48
    802031bc:	f406                	sd	ra,40(sp)
    802031be:	f022                	sd	s0,32(sp)
    802031c0:	1800                	add	s0,sp,48
    802031c2:	85aa                	mv	a1,a0
    802031c4:	feb43023          	sd	a1,-32(s0)

00000000802031c8 <.Lpcrel_hi1>:
    802031c8:	00003517          	auipc	a0,0x3
    802031cc:	5a850513          	add	a0,a0,1448 # 80206770 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h7520ca2061eddddcE>
    802031d0:	fea43423          	sd	a0,-24(s0)
    802031d4:	fcb43823          	sd	a1,-48(s0)
    802031d8:	fca43c23          	sd	a0,-40(s0)
    802031dc:	fd043503          	ld	a0,-48(s0)
    802031e0:	fd843583          	ld	a1,-40(s0)
    802031e4:	70a2                	ld	ra,40(sp)
    802031e6:	7402                	ld	s0,32(sp)
    802031e8:	6145                	add	sp,sp,48
    802031ea:	8082                	ret

00000000802031ec <_ZN4core3fmt10ArgumentV111new_display17haef2e9bd1ae24521E>:
    802031ec:	7179                	add	sp,sp,-48
    802031ee:	f406                	sd	ra,40(sp)
    802031f0:	f022                	sd	s0,32(sp)
    802031f2:	1800                	add	s0,sp,48
    802031f4:	85aa                	mv	a1,a0
    802031f6:	feb43023          	sd	a1,-32(s0)

00000000802031fa <.Lpcrel_hi2>:
    802031fa:	00000517          	auipc	a0,0x0
    802031fe:	f4450513          	add	a0,a0,-188 # 8020313e <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h09e42b22946a84abE>
    80203202:	fea43423          	sd	a0,-24(s0)
    80203206:	fcb43823          	sd	a1,-48(s0)
    8020320a:	fca43c23          	sd	a0,-40(s0)
    8020320e:	fd043503          	ld	a0,-48(s0)
    80203212:	fd843583          	ld	a1,-40(s0)
    80203216:	70a2                	ld	ra,40(sp)
    80203218:	7402                	ld	s0,32(sp)
    8020321a:	6145                	add	sp,sp,48
    8020321c:	8082                	ret

000000008020321e <_ZN4core3fmt10ArgumentV19new_debug17heedd7ca81b22fdd3E>:
    8020321e:	7179                	add	sp,sp,-48
    80203220:	f406                	sd	ra,40(sp)
    80203222:	f022                	sd	s0,32(sp)
    80203224:	1800                	add	s0,sp,48
    80203226:	85aa                	mv	a1,a0
    80203228:	feb43023          	sd	a1,-32(s0)

000000008020322c <.Lpcrel_hi4>:
    8020322c:	00002517          	auipc	a0,0x2
    80203230:	04450513          	add	a0,a0,68 # 80205270 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h6a04807329fcac14E>
    80203234:	fea43423          	sd	a0,-24(s0)
    80203238:	fcb43823          	sd	a1,-48(s0)
    8020323c:	fca43c23          	sd	a0,-40(s0)
    80203240:	fd043503          	ld	a0,-48(s0)
    80203244:	fd843583          	ld	a1,-40(s0)
    80203248:	70a2                	ld	ra,40(sp)
    8020324a:	7402                	ld	s0,32(sp)
    8020324c:	6145                	add	sp,sp,48
    8020324e:	8082                	ret

0000000080203250 <_ZN5riscv8register13hypervisorx647hstatus4read17hfae6f9138d080d16E>:
    80203250:	1101                	add	sp,sp,-32
    80203252:	ec06                	sd	ra,24(sp)
    80203254:	e822                	sd	s0,16(sp)
    80203256:	1000                	add	s0,sp,32
    80203258:	00000097          	auipc	ra,0x0
    8020325c:	018080e7          	jalr	24(ra) # 80203270 <_ZN5riscv8register13hypervisorx647hstatus5_read17hcda9eb6df6e39d05E>
    80203260:	fea43423          	sd	a0,-24(s0)
    80203264:	fe843503          	ld	a0,-24(s0)
    80203268:	60e2                	ld	ra,24(sp)
    8020326a:	6442                	ld	s0,16(sp)
    8020326c:	6105                	add	sp,sp,32
    8020326e:	8082                	ret

0000000080203270 <_ZN5riscv8register13hypervisorx647hstatus5_read17hcda9eb6df6e39d05E>:
    80203270:	1101                	add	sp,sp,-32
    80203272:	ec06                	sd	ra,24(sp)
    80203274:	e822                	sd	s0,16(sp)
    80203276:	1000                	add	s0,sp,32
    80203278:	60002573          	csrr	a0,hstatus
    8020327c:	fea43423          	sd	a0,-24(s0)
    80203280:	fe843503          	ld	a0,-24(s0)
    80203284:	60e2                	ld	ra,24(sp)
    80203286:	6442                	ld	s0,16(sp)
    80203288:	6105                	add	sp,sp,32
    8020328a:	8082                	ret

000000008020328c <_ZN5riscv8register13hypervisorx647hstatus7Hstatus4bits17hdccc00d3ae634d4eE>:
    8020328c:	1101                	add	sp,sp,-32
    8020328e:	ec06                	sd	ra,24(sp)
    80203290:	e822                	sd	s0,16(sp)
    80203292:	1000                	add	s0,sp,32
    80203294:	fea43423          	sd	a0,-24(s0)
    80203298:	6108                	ld	a0,0(a0)
    8020329a:	60e2                	ld	ra,24(sp)
    8020329c:	6442                	ld	s0,16(sp)
    8020329e:	6105                	add	sp,sp,32
    802032a0:	8082                	ret

00000000802032a2 <_ZN5riscv8register13hypervisorx647hstatus7Hstatus7set_spv17h9293b26d4ce9221cE>:
    802032a2:	1101                	add	sp,sp,-32
    802032a4:	ec06                	sd	ra,24(sp)
    802032a6:	e822                	sd	s0,16(sp)
    802032a8:	1000                	add	s0,sp,32
    802032aa:	862e                	mv	a2,a1
    802032ac:	fea43023          	sd	a0,-32(s0)
    802032b0:	fec407a3          	sb	a2,-17(s0)

00000000802032b4 <.Lpcrel_hi0>:
    802032b4:	00004597          	auipc	a1,0x4
    802032b8:	49458693          	add	a3,a1,1172 # 80207748 <.L__unnamed_1>
    802032bc:	459d                	li	a1,7
    802032be:	00001097          	auipc	ra,0x1
    802032c2:	e1c080e7          	jalr	-484(ra) # 802040da <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17h27dfc59eebaa642fE>
    802032c6:	60e2                	ld	ra,24(sp)
    802032c8:	6442                	ld	s0,16(sp)
    802032ca:	6105                	add	sp,sp,32
    802032cc:	8082                	ret

00000000802032ce <_ZN5riscv8register13hypervisorx645htval4read17hc57b67ab40213a91E>:
    802032ce:	1141                	add	sp,sp,-16
    802032d0:	e406                	sd	ra,8(sp)
    802032d2:	e022                	sd	s0,0(sp)
    802032d4:	0800                	add	s0,sp,16
    802032d6:	00000097          	auipc	ra,0x0
    802032da:	010080e7          	jalr	16(ra) # 802032e6 <_ZN5riscv8register13hypervisorx645htval5_read17h6ca5cae6663801d4E>
    802032de:	60a2                	ld	ra,8(sp)
    802032e0:	6402                	ld	s0,0(sp)
    802032e2:	0141                	add	sp,sp,16
    802032e4:	8082                	ret

00000000802032e6 <_ZN5riscv8register13hypervisorx645htval5_read17h6ca5cae6663801d4E>:
    802032e6:	1101                	add	sp,sp,-32
    802032e8:	ec06                	sd	ra,24(sp)
    802032ea:	e822                	sd	s0,16(sp)
    802032ec:	1000                	add	s0,sp,32
    802032ee:	64302573          	csrr	a0,htval
    802032f2:	fea43423          	sd	a0,-24(s0)
    802032f6:	fe843503          	ld	a0,-24(s0)
    802032fa:	60e2                	ld	ra,24(sp)
    802032fc:	6442                	ld	s0,16(sp)
    802032fe:	6105                	add	sp,sp,32
    80203300:	8082                	ret

0000000080203302 <_ZN4core3fmt9Arguments16new_v1_formatted17he59f970a69b4fc09E>:
    80203302:	711d                	add	sp,sp,-96
    80203304:	ec86                	sd	ra,88(sp)
    80203306:	e8a2                	sd	s0,80(sp)
    80203308:	1080                	add	s0,sp,96
    8020330a:	fab43c23          	sd	a1,-72(s0)
    8020330e:	fcc43023          	sd	a2,-64(s0)
    80203312:	fcd43423          	sd	a3,-56(s0)
    80203316:	fce43823          	sd	a4,-48(s0)
    8020331a:	fcf43c23          	sd	a5,-40(s0)
    8020331e:	ff043023          	sd	a6,-32(s0)
    80203322:	faf43423          	sd	a5,-88(s0)
    80203326:	fb043823          	sd	a6,-80(s0)
    8020332a:	e90c                	sd	a1,16(a0)
    8020332c:	ed10                	sd	a2,24(a0)
    8020332e:	fa843603          	ld	a2,-88(s0)
    80203332:	fb043583          	ld	a1,-80(s0)
    80203336:	e110                	sd	a2,0(a0)
    80203338:	e50c                	sd	a1,8(a0)
    8020333a:	f114                	sd	a3,32(a0)
    8020333c:	f518                	sd	a4,40(a0)
    8020333e:	60e6                	ld	ra,88(sp)
    80203340:	6446                	ld	s0,80(sp)
    80203342:	6125                	add	sp,sp,96
    80203344:	8082                	ret

0000000080203346 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E>:
    80203346:	7171                	add	sp,sp,-176
    80203348:	f506                	sd	ra,168(sp)
    8020334a:	f122                	sd	s0,160(sp)
    8020334c:	1900                	add	s0,sp,176
    8020334e:	f6e43023          	sd	a4,-160(s0)
    80203352:	f6d43423          	sd	a3,-152(s0)
    80203356:	f6c43823          	sd	a2,-144(s0)
    8020335a:	f6b43c23          	sd	a1,-136(s0)
    8020335e:	f8a43023          	sd	a0,-128(s0)
    80203362:	fcb43823          	sd	a1,-48(s0)
    80203366:	fcc43c23          	sd	a2,-40(s0)
    8020336a:	fed43023          	sd	a3,-32(s0)
    8020336e:	fee43423          	sd	a4,-24(s0)
    80203372:	00e66d63          	bltu	a2,a4,8020338c <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E+0x46>
    80203376:	a009                	j	80203378 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E+0x32>
    80203378:	f7043583          	ld	a1,-144(s0)
    8020337c:	f6043503          	ld	a0,-160(s0)
    80203380:	0505                	add	a0,a0,1
    80203382:	00b53533          	sltu	a0,a0,a1
    80203386:	f8a407a3          	sb	a0,-113(s0)
    8020338a:	a029                	j	80203394 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E+0x4e>
    8020338c:	4505                	li	a0,1
    8020338e:	f8a407a3          	sb	a0,-113(s0)
    80203392:	a009                	j	80203394 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E+0x4e>
    80203394:	f8f44503          	lbu	a0,-113(s0)
    80203398:	8905                	and	a0,a0,1
    8020339a:	ed0d                	bnez	a0,802033d4 <.Lpcrel_hi0>
    8020339c:	a009                	j	8020339e <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E+0x58>
    8020339e:	f6043503          	ld	a0,-160(s0)
    802033a2:	f8043583          	ld	a1,-128(s0)
    802033a6:	f6843603          	ld	a2,-152(s0)
    802033aa:	f7043683          	ld	a3,-144(s0)
    802033ae:	f7843703          	ld	a4,-136(s0)
    802033b2:	4781                	li	a5,0
    802033b4:	fcf43023          	sd	a5,-64(s0)
    802033b8:	e998                	sd	a4,16(a1)
    802033ba:	ed94                	sd	a3,24(a1)
    802033bc:	fc043703          	ld	a4,-64(s0)
    802033c0:	fc843683          	ld	a3,-56(s0)
    802033c4:	e198                	sd	a4,0(a1)
    802033c6:	e594                	sd	a3,8(a1)
    802033c8:	f190                	sd	a2,32(a1)
    802033ca:	f588                	sd	a0,40(a1)
    802033cc:	70aa                	ld	ra,168(sp)
    802033ce:	740a                	ld	s0,160(sp)
    802033d0:	614d                	add	sp,sp,176
    802033d2:	8082                	ret

00000000802033d4 <.Lpcrel_hi0>:
    802033d4:	00004517          	auipc	a0,0x4
    802033d8:	39c50593          	add	a1,a0,924 # 80207770 <.L__unnamed_1>
    802033dc:	f9040513          	add	a0,s0,-112
    802033e0:	f4a43c23          	sd	a0,-168(s0)
    802033e4:	4605                	li	a2,1
    802033e6:	00000097          	auipc	ra,0x0
    802033ea:	01e080e7          	jalr	30(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    802033ee:	f5843503          	ld	a0,-168(s0)

00000000802033f2 <.Lpcrel_hi1>:
    802033f2:	00004597          	auipc	a1,0x4
    802033f6:	3de58593          	add	a1,a1,990 # 802077d0 <.L__unnamed_2>
    802033fa:	00002097          	auipc	ra,0x2
    802033fe:	132080e7          	jalr	306(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>:
    80203404:	7119                	add	sp,sp,-128
    80203406:	fc86                	sd	ra,120(sp)
    80203408:	f8a2                	sd	s0,112(sp)
    8020340a:	0100                	add	s0,sp,128
    8020340c:	f8c43423          	sd	a2,-120(s0)
    80203410:	f8b43823          	sd	a1,-112(s0)
    80203414:	f8a43c23          	sd	a0,-104(s0)
    80203418:	feb43023          	sd	a1,-32(s0)
    8020341c:	fec43423          	sd	a2,-24(s0)
    80203420:	4505                	li	a0,1
    80203422:	02c56e63          	bltu	a0,a2,8020345e <.Lpcrel_hi3>
    80203426:	a009                	j	80203428 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E+0x24>
    80203428:	f9843583          	ld	a1,-104(s0)
    8020342c:	f8843603          	ld	a2,-120(s0)
    80203430:	f9043683          	ld	a3,-112(s0)
    80203434:	4501                	li	a0,0
    80203436:	fca43823          	sd	a0,-48(s0)
    8020343a:	e994                	sd	a3,16(a1)
    8020343c:	ed90                	sd	a2,24(a1)
    8020343e:	fd043683          	ld	a3,-48(s0)
    80203442:	fd843603          	ld	a2,-40(s0)
    80203446:	e194                	sd	a3,0(a1)
    80203448:	e590                	sd	a2,8(a1)

000000008020344a <.Lpcrel_hi2>:
    8020344a:	00004617          	auipc	a2,0x4
    8020344e:	3b660613          	add	a2,a2,950 # 80207800 <.L__unnamed_5>
    80203452:	f190                	sd	a2,32(a1)
    80203454:	f588                	sd	a0,40(a1)
    80203456:	70e6                	ld	ra,120(sp)
    80203458:	7446                	ld	s0,112(sp)
    8020345a:	6109                	add	sp,sp,128
    8020345c:	8082                	ret

000000008020345e <.Lpcrel_hi3>:
    8020345e:	00004517          	auipc	a0,0x4
    80203462:	31250593          	add	a1,a0,786 # 80207770 <.L__unnamed_1>
    80203466:	fa040513          	add	a0,s0,-96
    8020346a:	f8a43023          	sd	a0,-128(s0)
    8020346e:	4605                	li	a2,1
    80203470:	00000097          	auipc	ra,0x0
    80203474:	f94080e7          	jalr	-108(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    80203478:	f8043503          	ld	a0,-128(s0)

000000008020347c <.Lpcrel_hi4>:
    8020347c:	00004597          	auipc	a1,0x4
    80203480:	36c58593          	add	a1,a1,876 # 802077e8 <.L__unnamed_4>
    80203484:	00002097          	auipc	ra,0x2
    80203488:	0a8080e7          	jalr	168(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

000000008020348e <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE>:
    8020348e:	711d                	add	sp,sp,-96
    80203490:	ec86                	sd	ra,88(sp)
    80203492:	e8a2                	sd	s0,80(sp)
    80203494:	1080                	add	s0,sp,96
    80203496:	86b2                	mv	a3,a2
    80203498:	fad43023          	sd	a3,-96(s0)
    8020349c:	fca43023          	sd	a0,-64(s0)
    802034a0:	fcb43423          	sd	a1,-56(s0)
    802034a4:	fcc40ba3          	sb	a2,-41(s0)
    802034a8:	fffff097          	auipc	ra,0xfffff
    802034ac:	dc4080e7          	jalr	-572(ra) # 8020226c <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h35c928ae8fb300f3E>
    802034b0:	fca43c23          	sd	a0,-40(s0)
    802034b4:	feb43023          	sd	a1,-32(s0)
    802034b8:	faa43423          	sd	a0,-88(s0)
    802034bc:	fab43823          	sd	a1,-80(s0)
    802034c0:	a009                	j	802034c2 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE+0x34>
    802034c2:	fa840513          	add	a0,s0,-88
    802034c6:	fffff097          	auipc	ra,0xfffff
    802034ca:	f52080e7          	jalr	-174(ra) # 80202418 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he521f42ede8b2bd6E>
    802034ce:	faa43c23          	sd	a0,-72(s0)
    802034d2:	fb843503          	ld	a0,-72(s0)
    802034d6:	e511                	bnez	a0,802034e2 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE+0x54>
    802034d8:	a009                	j	802034da <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE+0x4c>
    802034da:	60e6                	ld	ra,88(sp)
    802034dc:	6446                	ld	s0,80(sp)
    802034de:	6125                	add	sp,sp,96
    802034e0:	8082                	ret
    802034e2:	fa043503          	ld	a0,-96(s0)
    802034e6:	fb843583          	ld	a1,-72(s0)
    802034ea:	feb43423          	sd	a1,-24(s0)
    802034ee:	00a58023          	sb	a0,0(a1)
    802034f2:	bfc1                	j	802034c2 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE+0x34>

00000000802034f4 <rust_begin_unwind>:
    802034f4:	7169                	add	sp,sp,-304
    802034f6:	f606                	sd	ra,296(sp)
    802034f8:	f222                	sd	s0,288(sp)
    802034fa:	1a00                	add	s0,sp,304
    802034fc:	f0a43423          	sd	a0,-248(s0)
    80203500:	fea43023          	sd	a0,-32(s0)
    80203504:	00002097          	auipc	ra,0x2
    80203508:	024080e7          	jalr	36(ra) # 80205528 <_ZN4core5panic10panic_info9PanicInfo8location17ha4fbac901d44a7d3E>
    8020350c:	f0a43823          	sd	a0,-240(s0)
    80203510:	f1043503          	ld	a0,-240(s0)
    80203514:	cd79                	beqz	a0,802035f2 <.Lpcrel_hi1+0x2e>
    80203516:	a009                	j	80203518 <rust_begin_unwind+0x24>
    80203518:	f1043503          	ld	a0,-240(s0)
    8020351c:	eca43c23          	sd	a0,-296(s0)
    80203520:	fea43423          	sd	a0,-24(s0)
    80203524:	ffffe097          	auipc	ra,0xffffe
    80203528:	3ec080e7          	jalr	1004(ra) # 80201910 <_ZN4core5panic8location8Location4file17hd364c6f0fc66a5a0E>
    8020352c:	f8b43023          	sd	a1,-128(s0)
    80203530:	f6a43c23          	sd	a0,-136(s0)
    80203534:	f7840513          	add	a0,s0,-136
    80203538:	00000097          	auipc	ra,0x0
    8020353c:	c50080e7          	jalr	-944(ra) # 80203188 <_ZN4core3fmt10ArgumentV111new_display17h04c26f2958d6c289E>
    80203540:	862a                	mv	a2,a0
    80203542:	ed843503          	ld	a0,-296(s0)
    80203546:	eec43023          	sd	a2,-288(s0)
    8020354a:	eeb43423          	sd	a1,-280(s0)
    8020354e:	ffffe097          	auipc	ra,0xffffe
    80203552:	3dc080e7          	jalr	988(ra) # 8020192a <_ZN4core5panic8location8Location4line17h86e5ccef841eb266E>
    80203556:	f8a42623          	sw	a0,-116(s0)
    8020355a:	f8c40513          	add	a0,s0,-116
    8020355e:	00000097          	auipc	ra,0x0
    80203562:	c5c080e7          	jalr	-932(ra) # 802031ba <_ZN4core3fmt10ArgumentV111new_display17ha5924b1057f0b37fE>
    80203566:	862a                	mv	a2,a0
    80203568:	f0843503          	ld	a0,-248(s0)
    8020356c:	eec43823          	sd	a2,-272(s0)
    80203570:	eeb43c23          	sd	a1,-264(s0)
    80203574:	00002097          	auipc	ra,0x2
    80203578:	fb0080e7          	jalr	-80(ra) # 80205524 <_ZN4core5panic10panic_info9PanicInfo7message17hb1db4e52e2d41520E>

000000008020357c <.Lpcrel_hi0>:
    8020357c:	00004597          	auipc	a1,0x4
    80203580:	3a458593          	add	a1,a1,932 # 80207920 <.L__unnamed_1>
    80203584:	ffffe097          	auipc	ra,0xffffe
    80203588:	1da080e7          	jalr	474(ra) # 8020175e <_ZN4core6option15Option$LT$T$GT$6unwrap17h411eb76940af9212E>
    8020358c:	f8a43823          	sd	a0,-112(s0)
    80203590:	f9040513          	add	a0,s0,-112
    80203594:	00000097          	auipc	ra,0x0
    80203598:	c58080e7          	jalr	-936(ra) # 802031ec <_ZN4core3fmt10ArgumentV111new_display17haef2e9bd1ae24521E>
    8020359c:	ee043783          	ld	a5,-288(s0)
    802035a0:	ee843703          	ld	a4,-280(s0)
    802035a4:	ef043683          	ld	a3,-272(s0)
    802035a8:	ef843603          	ld	a2,-264(s0)
    802035ac:	f4f43423          	sd	a5,-184(s0)
    802035b0:	f4e43823          	sd	a4,-176(s0)
    802035b4:	f4d43c23          	sd	a3,-168(s0)
    802035b8:	f6c43023          	sd	a2,-160(s0)
    802035bc:	f6a43423          	sd	a0,-152(s0)
    802035c0:	f6b43823          	sd	a1,-144(s0)

00000000802035c4 <.Lpcrel_hi1>:
    802035c4:	00004517          	auipc	a0,0x4
    802035c8:	31c50593          	add	a1,a0,796 # 802078e0 <.L__unnamed_2>
    802035cc:	f1840513          	add	a0,s0,-232
    802035d0:	f0a43023          	sd	a0,-256(s0)
    802035d4:	4611                	li	a2,4
    802035d6:	f4840693          	add	a3,s0,-184
    802035da:	470d                	li	a4,3
    802035dc:	00000097          	auipc	ra,0x0
    802035e0:	d6a080e7          	jalr	-662(ra) # 80203346 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E>
    802035e4:	f0043503          	ld	a0,-256(s0)
    802035e8:	fffff097          	auipc	ra,0xfffff
    802035ec:	fa8080e7          	jalr	-88(ra) # 80202590 <_ZN11hello_world7console5print17hf85a3294b456942fE>
    802035f0:	a095                	j	80203654 <.Lpcrel_hi3+0x2e>
    802035f2:	f0843503          	ld	a0,-248(s0)
    802035f6:	00002097          	auipc	ra,0x2
    802035fa:	f2e080e7          	jalr	-210(ra) # 80205524 <_ZN4core5panic10panic_info9PanicInfo7message17hb1db4e52e2d41520E>

00000000802035fe <.Lpcrel_hi2>:
    802035fe:	00004597          	auipc	a1,0x4
    80203602:	26258593          	add	a1,a1,610 # 80207860 <.L__unnamed_3>
    80203606:	ffffe097          	auipc	ra,0xffffe
    8020360a:	158080e7          	jalr	344(ra) # 8020175e <_ZN4core6option15Option$LT$T$GT$6unwrap17h411eb76940af9212E>
    8020360e:	fca43c23          	sd	a0,-40(s0)
    80203612:	fd840513          	add	a0,s0,-40
    80203616:	00000097          	auipc	ra,0x0
    8020361a:	bd6080e7          	jalr	-1066(ra) # 802031ec <_ZN4core3fmt10ArgumentV111new_display17haef2e9bd1ae24521E>
    8020361e:	fca43423          	sd	a0,-56(s0)
    80203622:	fcb43823          	sd	a1,-48(s0)

0000000080203626 <.Lpcrel_hi3>:
    80203626:	00004517          	auipc	a0,0x4
    8020362a:	1f250593          	add	a1,a0,498 # 80207818 <.L__unnamed_4>
    8020362e:	f9840513          	add	a0,s0,-104
    80203632:	eca43823          	sd	a0,-304(s0)
    80203636:	4609                	li	a2,2
    80203638:	fc840693          	add	a3,s0,-56
    8020363c:	4705                	li	a4,1
    8020363e:	00000097          	auipc	ra,0x0
    80203642:	d08080e7          	jalr	-760(ra) # 80203346 <_ZN4core3fmt9Arguments6new_v117h43cc7754fed88249E>
    80203646:	ed043503          	ld	a0,-304(s0)
    8020364a:	fffff097          	auipc	ra,0xfffff
    8020364e:	f46080e7          	jalr	-186(ra) # 80202590 <_ZN11hello_world7console5print17hf85a3294b456942fE>
    80203652:	a009                	j	80203654 <.Lpcrel_hi3+0x2e>
    80203654:	00000097          	auipc	ra,0x0
    80203658:	05e080e7          	jalr	94(ra) # 802036b2 <_ZN11hello_world3sbi8shutdown17h987e2d41c5b6ecd6E>
	...

000000008020365e <_ZN11hello_world9hyp_alloc9heap_init17h76623eba59b5b929E>:
    8020365e:	1141                	add	sp,sp,-16
    80203660:	e406                	sd	ra,8(sp)
    80203662:	e022                	sd	s0,0(sp)
    80203664:	0800                	add	s0,sp,16
    80203666:	ffffe097          	auipc	ra,0xffffe
    8020366a:	9ca080e7          	jalr	-1590(ra) # 80201030 <_ZN11hello_world9hyp_alloc14heap_allocator9init_heap17h58e6e88e1ffd912eE>
    8020366e:	ffffe097          	auipc	ra,0xffffe
    80203672:	24a080e7          	jalr	586(ra) # 802018b8 <_ZN11hello_world9hyp_alloc15frame_allocator20init_frame_allocator17h734b165da2386cfeE>
    80203676:	60a2                	ld	ra,8(sp)
    80203678:	6402                	ld	s0,0(sp)
    8020367a:	0141                	add	sp,sp,16
    8020367c:	8082                	ret

000000008020367e <_ZN11hello_world3sbi15console_putchar17h42168a51a2978df3E>:
    8020367e:	7139                	add	sp,sp,-64
    80203680:	fc06                	sd	ra,56(sp)
    80203682:	f822                	sd	s0,48(sp)
    80203684:	0080                	add	s0,sp,64
    80203686:	fca43023          	sd	a0,-64(s0)
    8020368a:	4885                	li	a7,1
    8020368c:	fd143823          	sd	a7,-48(s0)
    80203690:	fca43c23          	sd	a0,-40(s0)
    80203694:	4601                	li	a2,0
    80203696:	fec43023          	sd	a2,-32(s0)
    8020369a:	fec43423          	sd	a2,-24(s0)
    8020369e:	85b2                	mv	a1,a2
    802036a0:	4801                	li	a6,0
    802036a2:	00000073          	ecall
    802036a6:	fca43423          	sd	a0,-56(s0)
    802036aa:	70e2                	ld	ra,56(sp)
    802036ac:	7442                	ld	s0,48(sp)
    802036ae:	6121                	add	sp,sp,64
    802036b0:	8082                	ret

00000000802036b2 <_ZN11hello_world3sbi8shutdown17h987e2d41c5b6ecd6E>:
    802036b2:	1141                	add	sp,sp,-16
    802036b4:	e406                	sd	ra,8(sp)
    802036b6:	e022                	sd	s0,0(sp)
    802036b8:	0800                	add	s0,sp,16
    802036ba:	00001097          	auipc	ra,0x1
    802036be:	8e4080e7          	jalr	-1820(ra) # 80203f9e <_ZN6sbi_rt4srst12system_reset17he21f6bcec193366cE>

00000000802036c2 <.Lpcrel_hi0>:
    802036c2:	00004517          	auipc	a0,0x4
    802036c6:	27650513          	add	a0,a0,630 # 80207938 <.L__unnamed_1>

00000000802036ca <.Lpcrel_hi1>:
    802036ca:	00004597          	auipc	a1,0x4
    802036ce:	2b658613          	add	a2,a1,694 # 80207980 <.L__unnamed_2>
    802036d2:	02800593          	li	a1,40
    802036d6:	00002097          	auipc	ra,0x2
    802036da:	e84080e7          	jalr	-380(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

00000000802036e0 <_ZN4core4sync6atomic10AtomicBool3new17h6d6eeb31741e1d39E>:
    802036e0:	1101                	add	sp,sp,-32
    802036e2:	ec06                	sd	ra,24(sp)
    802036e4:	e822                	sd	s0,16(sp)
    802036e6:	1000                	add	s0,sp,32
    802036e8:	fea40723          	sb	a0,-18(s0)
    802036ec:	fea407a3          	sb	a0,-17(s0)
    802036f0:	fea406a3          	sb	a0,-19(s0)
    802036f4:	fed40503          	lb	a0,-19(s0)
    802036f8:	fea40423          	sb	a0,-24(s0)
    802036fc:	fe840503          	lb	a0,-24(s0)
    80203700:	60e2                	ld	ra,24(sp)
    80203702:	6442                	ld	s0,16(sp)
    80203704:	6105                	add	sp,sp,32
    80203706:	8082                	ret

0000000080203708 <_ZN4core4sync6atomic11AtomicUsize4load17h79eb8912deb096faE>:
    80203708:	7179                	add	sp,sp,-48
    8020370a:	f406                	sd	ra,40(sp)
    8020370c:	f022                	sd	s0,32(sp)
    8020370e:	1800                	add	s0,sp,48
    80203710:	fca43c23          	sd	a0,-40(s0)
    80203714:	feb403a3          	sb	a1,-25(s0)
    80203718:	fea43423          	sd	a0,-24(s0)
    8020371c:	00001097          	auipc	ra,0x1
    80203720:	466080e7          	jalr	1126(ra) # 80204b82 <_ZN4core4sync6atomic11atomic_load17hfe406beff556b5f5E>
    80203724:	70a2                	ld	ra,40(sp)
    80203726:	7402                	ld	s0,32(sp)
    80203728:	6145                	add	sp,sp,48
    8020372a:	8082                	ret

000000008020372c <_ZN4core4sync6atomic11AtomicUsize9fetch_add17h2a3f763a88e4912dE>:
    8020372c:	711d                	add	sp,sp,-96
    8020372e:	ec86                	sd	ra,88(sp)
    80203730:	e8a2                	sd	s0,80(sp)
    80203732:	1080                	add	s0,sp,96
    80203734:	fab43423          	sd	a1,-88(s0)
    80203738:	faa43823          	sd	a0,-80(s0)
    8020373c:	fcc403a3          	sb	a2,-57(s0)
    80203740:	fca43823          	sd	a0,-48(s0)
    80203744:	fcb43c23          	sd	a1,-40(s0)
    80203748:	fea43023          	sd	a0,-32(s0)
    8020374c:	fea43423          	sd	a0,-24(s0)
    80203750:	fc744503          	lbu	a0,-57(s0)
    80203754:	faa43c23          	sd	a0,-72(s0)
    80203758:	fb843503          	ld	a0,-72(s0)
    8020375c:	050e                	sll	a0,a0,0x3

000000008020375e <.Lpcrel_hi0>:
    8020375e:	00004597          	auipc	a1,0x4
    80203762:	23a58593          	add	a1,a1,570 # 80207998 <.LJTI2_0>
    80203766:	952e                	add	a0,a0,a1
    80203768:	6108                	ld	a0,0(a0)
    8020376a:	8502                	jr	a0
	...

000000008020376e <.LBB2_3>:
    8020376e:	fb043503          	ld	a0,-80(s0)
    80203772:	fa843583          	ld	a1,-88(s0)
    80203776:	00b5352f          	amoadd.d	a0,a1,(a0)
    8020377a:	fca43423          	sd	a0,-56(s0)
    8020377e:	a0a9                	j	802037c8 <.LBB2_7+0x12>

0000000080203780 <.LBB2_4>:
    80203780:	fb043503          	ld	a0,-80(s0)
    80203784:	fa843583          	ld	a1,-88(s0)
    80203788:	02b5352f          	amoadd.d.rl	a0,a1,(a0)
    8020378c:	fca43423          	sd	a0,-56(s0)
    80203790:	a825                	j	802037c8 <.LBB2_7+0x12>

0000000080203792 <.LBB2_5>:
    80203792:	fb043503          	ld	a0,-80(s0)
    80203796:	fa843583          	ld	a1,-88(s0)
    8020379a:	04b5352f          	amoadd.d.aq	a0,a1,(a0)
    8020379e:	fca43423          	sd	a0,-56(s0)
    802037a2:	a01d                	j	802037c8 <.LBB2_7+0x12>

00000000802037a4 <.LBB2_6>:
    802037a4:	fb043503          	ld	a0,-80(s0)
    802037a8:	fa843583          	ld	a1,-88(s0)
    802037ac:	06b5352f          	amoadd.d.aqrl	a0,a1,(a0)
    802037b0:	fca43423          	sd	a0,-56(s0)
    802037b4:	a811                	j	802037c8 <.LBB2_7+0x12>

00000000802037b6 <.LBB2_7>:
    802037b6:	fb043503          	ld	a0,-80(s0)
    802037ba:	fa843583          	ld	a1,-88(s0)
    802037be:	06b5352f          	amoadd.d.aqrl	a0,a1,(a0)
    802037c2:	fca43423          	sd	a0,-56(s0)
    802037c6:	a009                	j	802037c8 <.LBB2_7+0x12>
    802037c8:	fc843503          	ld	a0,-56(s0)
    802037cc:	60e6                	ld	ra,88(sp)
    802037ce:	6446                	ld	s0,80(sp)
    802037d0:	6125                	add	sp,sp,96
    802037d2:	8082                	ret

00000000802037d4 <_ZN4core4sync6atomic14spin_loop_hint17h39eb60b027d73982E>:
    802037d4:	1141                	add	sp,sp,-16
    802037d6:	e406                	sd	ra,8(sp)
    802037d8:	e022                	sd	s0,0(sp)
    802037da:	0800                	add	s0,sp,16
    802037dc:	0100000f          	fence	w,unknown
    802037e0:	60a2                	ld	ra,8(sp)
    802037e2:	6402                	ld	s0,0(sp)
    802037e4:	0141                	add	sp,sp,16
    802037e6:	8082                	ret

00000000802037e8 <_ZN4core4sync6atomic8AtomicU816compare_exchange17h8a05f20fb369baa7E>:
    802037e8:	7179                	add	sp,sp,-48
    802037ea:	f406                	sd	ra,40(sp)
    802037ec:	f022                	sd	s0,32(sp)
    802037ee:	1800                	add	s0,sp,48
    802037f0:	fca43c23          	sd	a0,-40(s0)
    802037f4:	feb40223          	sb	a1,-28(s0)
    802037f8:	fec402a3          	sb	a2,-27(s0)
    802037fc:	fed40323          	sb	a3,-26(s0)
    80203800:	fee403a3          	sb	a4,-25(s0)
    80203804:	fea43423          	sd	a0,-24(s0)
    80203808:	fffff097          	auipc	ra,0xfffff
    8020380c:	fa0080e7          	jalr	-96(ra) # 802027a8 <_ZN4core4sync6atomic23atomic_compare_exchange17h80444466ad3bca60E>
    80203810:	8905                	and	a0,a0,1
    80203812:	70a2                	ld	ra,40(sp)
    80203814:	7402                	ld	s0,32(sp)
    80203816:	6145                	add	sp,sp,48
    80203818:	8082                	ret

000000008020381a <_ZN4core4sync6atomic8AtomicU84load17h76a4bc9d7c5a48f0E>:
    8020381a:	7179                	add	sp,sp,-48
    8020381c:	f406                	sd	ra,40(sp)
    8020381e:	f022                	sd	s0,32(sp)
    80203820:	1800                	add	s0,sp,48
    80203822:	fca43c23          	sd	a0,-40(s0)
    80203826:	feb403a3          	sb	a1,-25(s0)
    8020382a:	fea43423          	sd	a0,-24(s0)
    8020382e:	fffff097          	auipc	ra,0xfffff
    80203832:	ea6080e7          	jalr	-346(ra) # 802026d4 <_ZN4core4sync6atomic11atomic_load17habdcb365fcee2ab0E>
    80203836:	70a2                	ld	ra,40(sp)
    80203838:	7402                	ld	s0,32(sp)
    8020383a:	6145                	add	sp,sp,48
    8020383c:	8082                	ret

000000008020383e <_ZN4core4sync6atomic8AtomicU85store17h285e44554cbc7f62E>:
    8020383e:	7179                	add	sp,sp,-48
    80203840:	f406                	sd	ra,40(sp)
    80203842:	f022                	sd	s0,32(sp)
    80203844:	1800                	add	s0,sp,48
    80203846:	fca43c23          	sd	a0,-40(s0)
    8020384a:	feb40323          	sb	a1,-26(s0)
    8020384e:	fec403a3          	sb	a2,-25(s0)
    80203852:	fea43423          	sd	a0,-24(s0)
    80203856:	00001097          	auipc	ra,0x1
    8020385a:	4de080e7          	jalr	1246(ra) # 80204d34 <_ZN4core4sync6atomic12atomic_store17h093b066d284101fdE>
    8020385e:	70a2                	ld	ra,40(sp)
    80203860:	7402                	ld	s0,32(sp)
    80203862:	6145                	add	sp,sp,48
    80203864:	8082                	ret

0000000080203866 <_ZN81_$LT$hello_world..HyperCraftHalImpl$u20$as$u20$hypercraft..hal..HyperCraftHal$GT$14vmexit_handler17h8e7820c02ec1aa70E>:
    80203866:	d8010113          	add	sp,sp,-640
    8020386a:	26113c23          	sd	ra,632(sp)
    8020386e:	26813823          	sd	s0,624(sp)
    80203872:	0500                	add	s0,sp,640
    80203874:	f0a43c23          	sd	a0,-232(s0)
    80203878:	00000097          	auipc	ra,0x0
    8020387c:	4d8080e7          	jalr	1240(ra) # 80203d50 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$10trap_cause17h5ef68bfd5dbe7c2cE>

0000000080203880 <.Lpcrel_hi4>:
    80203880:	00004617          	auipc	a2,0x4
    80203884:	16060613          	add	a2,a2,352 # 802079e0 <.L__unnamed_2>
    80203888:	ffffe097          	auipc	ra,0xffffe
    8020388c:	e84080e7          	jalr	-380(ra) # 8020170c <_ZN4core6option15Option$LT$T$GT$6unwrap17h33e2ac82c9c2bc3aE>
    80203890:	d8b40ca3          	sb	a1,-615(s0)
    80203894:	d8a40c23          	sb	a0,-616(s0)
    80203898:	d9844503          	lbu	a0,-616(s0)
    8020389c:	8905                	and	a0,a0,1
    8020389e:	c901                	beqz	a0,802038ae <.Lpcrel_hi4+0x2e>
    802038a0:	a009                	j	802038a2 <.Lpcrel_hi4+0x22>
    802038a2:	d9944503          	lbu	a0,-615(s0)
    802038a6:	45a1                	li	a1,8
    802038a8:	20b50963          	beq	a0,a1,80203aba <.Lpcrel_hi7>
    802038ac:	a009                	j	802038ae <.Lpcrel_hi4+0x2e>
    802038ae:	ffffe097          	auipc	ra,0xffffe
    802038b2:	85a080e7          	jalr	-1958(ra) # 80201108 <_ZN5riscv8register4sepc4read17had64edd427345954E>
    802038b6:	dea43823          	sd	a0,-528(s0)
    802038ba:	df040513          	add	a0,s0,-528
    802038be:	00001097          	auipc	ra,0x1
    802038c2:	c80080e7          	jalr	-896(ra) # 8020453e <_ZN4core3fmt10ArgumentV113new_lower_hex17ha4c466433c3965dfE>
    802038c6:	d8a43023          	sd	a0,-640(s0)
    802038ca:	d8b43423          	sd	a1,-632(s0)
    802038ce:	d9840513          	add	a0,s0,-616
    802038d2:	00000097          	auipc	ra,0x0
    802038d6:	94c080e7          	jalr	-1716(ra) # 8020321e <_ZN4core3fmt10ArgumentV19new_debug17heedd7ca81b22fdd3E>
    802038da:	d8043683          	ld	a3,-640(s0)
    802038de:	d8843603          	ld	a2,-632(s0)
    802038e2:	dcd43823          	sd	a3,-560(s0)
    802038e6:	dcc43c23          	sd	a2,-552(s0)
    802038ea:	dea43023          	sd	a0,-544(s0)
    802038ee:	deb43423          	sd	a1,-536(s0)
    802038f2:	4809                	li	a6,2
    802038f4:	eb043023          	sd	a6,-352(s0)
    802038f8:	eb043823          	sd	a6,-336(s0)
    802038fc:	ea043683          	ld	a3,-352(s0)
    80203900:	ea843603          	ld	a2,-344(s0)
    80203904:	eb043583          	ld	a1,-336(s0)
    80203908:	eb843503          	ld	a0,-328(s0)
    8020390c:	4781                	li	a5,0
    8020390e:	faf43c23          	sd	a5,-72(s0)
    80203912:	02000293          	li	t0,32
    80203916:	fc542223          	sw	t0,-60(s0)
    8020391a:	488d                	li	a7,3
    8020391c:	fd1405a3          	sb	a7,-53(s0)
    80203920:	4711                	li	a4,4
    80203922:	fce42623          	sw	a4,-52(s0)
    80203926:	fcd43823          	sd	a3,-48(s0)
    8020392a:	fcc43c23          	sd	a2,-40(s0)
    8020392e:	feb43023          	sd	a1,-32(s0)
    80203932:	fea43423          	sd	a0,-24(s0)
    80203936:	fa542623          	sw	t0,-84(s0)
    8020393a:	fb140823          	sb	a7,-80(s0)
    8020393e:	fae42423          	sw	a4,-88(s0)
    80203942:	f8d43423          	sd	a3,-120(s0)
    80203946:	f8c43823          	sd	a2,-112(s0)
    8020394a:	f8b43c23          	sd	a1,-104(s0)
    8020394e:	faa43023          	sd	a0,-96(s0)
    80203952:	e8f43c23          	sd	a5,-360(s0)
    80203956:	fb043503          	ld	a0,-80(s0)
    8020395a:	e8a43823          	sd	a0,-368(s0)
    8020395e:	fa843503          	ld	a0,-88(s0)
    80203962:	e8a43423          	sd	a0,-376(s0)
    80203966:	fa043503          	ld	a0,-96(s0)
    8020396a:	e8a43023          	sd	a0,-384(s0)
    8020396e:	f9843503          	ld	a0,-104(s0)
    80203972:	e6a43c23          	sd	a0,-392(s0)
    80203976:	f9043503          	ld	a0,-112(s0)
    8020397a:	e6a43823          	sd	a0,-400(s0)
    8020397e:	f8843503          	ld	a0,-120(s0)
    80203982:	e6a43423          	sd	a0,-408(s0)
    80203986:	ef043c23          	sd	a6,-264(s0)
    8020398a:	f1043423          	sd	a6,-248(s0)
    8020398e:	ef843703          	ld	a4,-264(s0)
    80203992:	f0043683          	ld	a3,-256(s0)
    80203996:	f0843603          	ld	a2,-248(s0)
    8020399a:	f1043583          	ld	a1,-240(s0)
    8020399e:	4505                	li	a0,1
    802039a0:	f4a43823          	sd	a0,-176(s0)
    802039a4:	f4542e23          	sw	t0,-164(s0)
    802039a8:	f71401a3          	sb	a7,-157(s0)
    802039ac:	f6f42223          	sw	a5,-156(s0)
    802039b0:	f6e43423          	sd	a4,-152(s0)
    802039b4:	f6d43823          	sd	a3,-144(s0)
    802039b8:	f6c43c23          	sd	a2,-136(s0)
    802039bc:	f8b43023          	sd	a1,-128(s0)
    802039c0:	f4542223          	sw	t0,-188(s0)
    802039c4:	f5140423          	sb	a7,-184(s0)
    802039c8:	f4f42023          	sw	a5,-192(s0)
    802039cc:	f2e43023          	sd	a4,-224(s0)
    802039d0:	f2d43423          	sd	a3,-216(s0)
    802039d4:	f2c43823          	sd	a2,-208(s0)
    802039d8:	f2b43c23          	sd	a1,-200(s0)
    802039dc:	eea43823          	sd	a0,-272(s0)
    802039e0:	f4843503          	ld	a0,-184(s0)
    802039e4:	eea43423          	sd	a0,-280(s0)
    802039e8:	f4043503          	ld	a0,-192(s0)
    802039ec:	eea43023          	sd	a0,-288(s0)
    802039f0:	f3843503          	ld	a0,-200(s0)
    802039f4:	eca43c23          	sd	a0,-296(s0)
    802039f8:	f3043503          	ld	a0,-208(s0)
    802039fc:	eca43823          	sd	a0,-304(s0)
    80203a00:	f2843503          	ld	a0,-216(s0)
    80203a04:	eca43423          	sd	a0,-312(s0)
    80203a08:	f2043503          	ld	a0,-224(s0)
    80203a0c:	eca43023          	sd	a0,-320(s0)
    80203a10:	e9843503          	ld	a0,-360(s0)
    80203a14:	e2a43423          	sd	a0,-472(s0)
    80203a18:	e9043503          	ld	a0,-368(s0)
    80203a1c:	e2a43023          	sd	a0,-480(s0)
    80203a20:	e8843503          	ld	a0,-376(s0)
    80203a24:	e0a43c23          	sd	a0,-488(s0)
    80203a28:	e8043503          	ld	a0,-384(s0)
    80203a2c:	e0a43823          	sd	a0,-496(s0)
    80203a30:	e7843503          	ld	a0,-392(s0)
    80203a34:	e0a43423          	sd	a0,-504(s0)
    80203a38:	e7043503          	ld	a0,-400(s0)
    80203a3c:	e0a43023          	sd	a0,-512(s0)
    80203a40:	e6843503          	ld	a0,-408(s0)
    80203a44:	dea43c23          	sd	a0,-520(s0)
    80203a48:	ef043503          	ld	a0,-272(s0)
    80203a4c:	e6a43023          	sd	a0,-416(s0)
    80203a50:	ee843503          	ld	a0,-280(s0)
    80203a54:	e4a43c23          	sd	a0,-424(s0)
    80203a58:	ee043503          	ld	a0,-288(s0)
    80203a5c:	e4a43823          	sd	a0,-432(s0)
    80203a60:	ed843503          	ld	a0,-296(s0)
    80203a64:	e4a43423          	sd	a0,-440(s0)
    80203a68:	ed043503          	ld	a0,-304(s0)
    80203a6c:	e4a43023          	sd	a0,-448(s0)
    80203a70:	ec843503          	ld	a0,-312(s0)
    80203a74:	e2a43c23          	sd	a0,-456(s0)
    80203a78:	ec043503          	ld	a0,-320(s0)
    80203a7c:	e2a43823          	sd	a0,-464(s0)

0000000080203a80 <.Lpcrel_hi5>:
    80203a80:	00004517          	auipc	a0,0x4
    80203a84:	f8850593          	add	a1,a0,-120 # 80207a08 <.L__unnamed_3>
    80203a88:	da040513          	add	a0,s0,-608
    80203a8c:	d8a43823          	sd	a0,-624(s0)
    80203a90:	dd040693          	add	a3,s0,-560
    80203a94:	df840793          	add	a5,s0,-520
    80203a98:	8642                	mv	a2,a6
    80203a9a:	8742                	mv	a4,a6
    80203a9c:	00000097          	auipc	ra,0x0
    80203aa0:	866080e7          	jalr	-1946(ra) # 80203302 <_ZN4core3fmt9Arguments16new_v1_formatted17he59f970a69b4fc09E>
    80203aa4:	d9043503          	ld	a0,-624(s0)

0000000080203aa8 <.Lpcrel_hi6>:
    80203aa8:	00004597          	auipc	a1,0x4
    80203aac:	f8058593          	add	a1,a1,-128 # 80207a28 <.L__unnamed_4>
    80203ab0:	00002097          	auipc	ra,0x2
    80203ab4:	a7c080e7          	jalr	-1412(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080203aba <.Lpcrel_hi7>:
    80203aba:	00004517          	auipc	a0,0x4
    80203abe:	f8650513          	add	a0,a0,-122 # 80207a40 <.L__unnamed_5>

0000000080203ac2 <.Lpcrel_hi8>:
    80203ac2:	00004597          	auipc	a1,0x4
    80203ac6:	f8e58613          	add	a2,a1,-114 # 80207a50 <.L__unnamed_6>
    80203aca:	45b9                	li	a1,14
    80203acc:	00002097          	auipc	ra,0x2
    80203ad0:	a8e080e7          	jalr	-1394(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080203ad6 <_ZN11hello_world9clear_bss17ha44bb0334def3778E>:
    80203ad6:	1141                	add	sp,sp,-16
    80203ad8:	e406                	sd	ra,8(sp)
    80203ada:	e022                	sd	s0,0(sp)
    80203adc:	0800                	add	s0,sp,16

0000000080203ade <.Lpcrel_hi9>:
    80203ade:	00017517          	auipc	a0,0x17
    80203ae2:	52250593          	add	a1,a0,1314 # 8021b000 <_ZN11hello_world9hyp_alloc14heap_allocator10HEAP_SPACE17h16e95a0fea74a537E>

0000000080203ae6 <.Lpcrel_hi10>:
    80203ae6:	00318517          	auipc	a0,0x318
    80203aea:	51a50513          	add	a0,a0,1306 # 8051c000 <ebss>
    80203aee:	02b56963          	bltu	a0,a1,80203b20 <.Lpcrel_hi13>
    80203af2:	a009                	j	80203af4 <.Lpcrel_hi11>

0000000080203af4 <.Lpcrel_hi11>:
    80203af4:	00017517          	auipc	a0,0x17
    80203af8:	50c50513          	add	a0,a0,1292 # 8021b000 <_ZN11hello_world9hyp_alloc14heap_allocator10HEAP_SPACE17h16e95a0fea74a537E>

0000000080203afc <.Lpcrel_hi12>:
    80203afc:	00318597          	auipc	a1,0x318
    80203b00:	50458593          	add	a1,a1,1284 # 8051c000 <ebss>
    80203b04:	8d89                	sub	a1,a1,a0
    80203b06:	00000097          	auipc	ra,0x0
    80203b0a:	510080e7          	jalr	1296(ra) # 80204016 <_ZN4core5slice3raw18from_raw_parts_mut17h14a1da24eb7f929aE>
    80203b0e:	4601                	li	a2,0
    80203b10:	00000097          	auipc	ra,0x0
    80203b14:	436080e7          	jalr	1078(ra) # 80203f46 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4fill17hc24eb31986d1989aE>
    80203b18:	60a2                	ld	ra,8(sp)
    80203b1a:	6402                	ld	s0,0(sp)
    80203b1c:	0141                	add	sp,sp,16
    80203b1e:	8082                	ret

0000000080203b20 <.Lpcrel_hi13>:
    80203b20:	00004517          	auipc	a0,0x4
    80203b24:	f6050513          	add	a0,a0,-160 # 80207a80 <str.0>

0000000080203b28 <.Lpcrel_hi14>:
    80203b28:	00004597          	auipc	a1,0x4
    80203b2c:	f4058613          	add	a2,a1,-192 # 80207a68 <.L__unnamed_7>
    80203b30:	02100593          	li	a1,33
    80203b34:	00002097          	auipc	ra,0x2
    80203b38:	a26080e7          	jalr	-1498(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080203b3e <hentry>:
    80203b3e:	cd010113          	add	sp,sp,-816
    80203b42:	32113423          	sd	ra,808(sp)
    80203b46:	32813023          	sd	s0,800(sp)
    80203b4a:	1e00                	add	s0,sp,816
    80203b4c:	00000097          	auipc	ra,0x0
    80203b50:	f8a080e7          	jalr	-118(ra) # 80203ad6 <_ZN11hello_world9clear_bss17ha44bb0334def3778E>
    80203b54:	00000097          	auipc	ra,0x0
    80203b58:	b0a080e7          	jalr	-1270(ra) # 8020365e <_ZN11hello_world9hyp_alloc9heap_init17h76623eba59b5b929E>

0000000080203b5c <.Lpcrel_hi15>:
    80203b5c:	00004517          	auipc	a0,0x4
    80203b60:	f6450593          	add	a1,a0,-156 # 80207ac0 <.L__unnamed_8>
    80203b64:	ce840513          	add	a0,s0,-792
    80203b68:	cca43c23          	sd	a0,-808(s0)
    80203b6c:	4605                	li	a2,1
    80203b6e:	00000097          	auipc	ra,0x0
    80203b72:	896080e7          	jalr	-1898(ra) # 80203404 <_ZN4core3fmt9Arguments9new_const17hbda2222620aee568E>
    80203b76:	cd843503          	ld	a0,-808(s0)
    80203b7a:	fffff097          	auipc	ra,0xfffff
    80203b7e:	a16080e7          	jalr	-1514(ra) # 80202590 <_ZN11hello_world7console5print17hf85a3294b456942fE>
    80203b82:	4525                	li	a0,9
    80203b84:	01c51593          	sll	a1,a0,0x1c
    80203b88:	d1840513          	add	a0,s0,-744
    80203b8c:	cea43023          	sd	a0,-800(s0)
    80203b90:	00000097          	auipc	ra,0x0
    80203b94:	292080e7          	jalr	658(ra) # 80203e22 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$6create17h95ac8a1e9e575535E>
    80203b98:	ce043503          	ld	a0,-800(s0)
    80203b9c:	00000097          	auipc	ra,0x0
    80203ba0:	1d2080e7          	jalr	466(ra) # 80203d6e <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$3run17had6912c16d3d39a0E>

0000000080203ba4 <.Lpcrel_hi16>:
    80203ba4:	00004517          	auipc	a0,0x4
    80203ba8:	f2c50513          	add	a0,a0,-212 # 80207ad0 <.L__unnamed_9>

0000000080203bac <.Lpcrel_hi17>:
    80203bac:	00004597          	auipc	a1,0x4
    80203bb0:	f4c58613          	add	a2,a1,-180 # 80207af8 <.L__unnamed_10>
    80203bb4:	02800593          	li	a1,40
    80203bb8:	00002097          	auipc	ra,0x2
    80203bbc:	9a2080e7          	jalr	-1630(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080203bc2 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8fc13925b6d41ff6E>:
    80203bc2:	7179                	add	sp,sp,-48
    80203bc4:	f406                	sd	ra,40(sp)
    80203bc6:	f022                	sd	s0,32(sp)
    80203bc8:	1800                	add	s0,sp,48
    80203bca:	fcb43823          	sd	a1,-48(s0)
    80203bce:	fca40fa3          	sb	a0,-33(s0)
    80203bd2:	fdf44503          	lbu	a0,-33(s0)
    80203bd6:	8905                	and	a0,a0,1
    80203bd8:	e511                	bnez	a0,80203be4 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8fc13925b6d41ff6E+0x22>
    80203bda:	a009                	j	80203bdc <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8fc13925b6d41ff6E+0x1a>
    80203bdc:	70a2                	ld	ra,40(sp)
    80203bde:	7402                	ld	s0,32(sp)
    80203be0:	6145                	add	sp,sp,48
    80203be2:	8082                	ret
    80203be4:	fd043703          	ld	a4,-48(s0)

0000000080203be8 <.Lpcrel_hi0>:
    80203be8:	00004517          	auipc	a0,0x4
    80203bec:	f2850513          	add	a0,a0,-216 # 80207b10 <.L__unnamed_2>

0000000080203bf0 <.Lpcrel_hi1>:
    80203bf0:	00004597          	auipc	a1,0x4
    80203bf4:	f5058693          	add	a3,a1,-176 # 80207b40 <.L__unnamed_1>
    80203bf8:	02b00593          	li	a1,43
    80203bfc:	fe040613          	add	a2,s0,-32
    80203c00:	00002097          	auipc	ra,0x2
    80203c04:	a2c080e7          	jalr	-1492(ra) # 8020562c <_ZN4core6result13unwrap_failed17h8c53b89a3c60dfa4E>
	...

0000000080203c0a <_ZN11hello_world9hyp_alloc15frame_allocator20init_frame_allocator28_$u7b$$u7b$closure$u7d$$u7d$17h5c827a3b806607ceE>:
    80203c0a:	7111                	add	sp,sp,-256
    80203c0c:	fd86                	sd	ra,248(sp)
    80203c0e:	f9a2                	sd	s0,240(sp)
    80203c10:	0200                	add	s0,sp,256
    80203c12:	f0a43c23          	sd	a0,-232(s0)
    80203c16:	f2040513          	add	a0,s0,-224
    80203c1a:	f0a43823          	sd	a0,-240(s0)
    80203c1e:	ffffe097          	auipc	ra,0xffffe
    80203c22:	c5e080e7          	jalr	-930(ra) # 8020187c <_ZN136_$LT$hello_world..hyp_alloc..frame_allocator..StackFrameAllocator$u20$as$u20$hello_world..hyp_alloc..frame_allocator..FrameAllocator$GT$3new17hfc05673ada866e4bE>

0000000080203c26 <.Lpcrel_hi0>:
    80203c26:	00318517          	auipc	a0,0x318
    80203c2a:	3da50513          	add	a0,a0,986 # 8051c000 <ebss>
    80203c2e:	ffffe097          	auipc	ra,0xffffe
    80203c32:	b72080e7          	jalr	-1166(ra) # 802017a0 <_ZN102_$LT$hello_world..hyp_alloc..frame_allocator..PhysAddr$u20$as$u20$core..convert..From$LT$usize$GT$$GT$4from17h10d239523ad20ffeE>
    80203c36:	f4a43423          	sd	a0,-184(s0)
    80203c3a:	f4840513          	add	a0,s0,-184
    80203c3e:	ffffe097          	auipc	ra,0xffffe
    80203c42:	ba2080e7          	jalr	-1118(ra) # 802017e0 <_ZN11hello_world9hyp_alloc15frame_allocator8PhysAddr4ceil17h0ea9f8b6732fc818E>
    80203c46:	f0a43423          	sd	a0,-248(s0)
    80203c4a:	4545                	li	a0,17
    80203c4c:	056e                	sll	a0,a0,0x1b
    80203c4e:	ffffe097          	auipc	ra,0xffffe
    80203c52:	b52080e7          	jalr	-1198(ra) # 802017a0 <_ZN102_$LT$hello_world..hyp_alloc..frame_allocator..PhysAddr$u20$as$u20$core..convert..From$LT$usize$GT$$GT$4from17h10d239523ad20ffeE>
    80203c56:	f4a43823          	sd	a0,-176(s0)
    80203c5a:	f5040513          	add	a0,s0,-176
    80203c5e:	ffffe097          	auipc	ra,0xffffe
    80203c62:	b62080e7          	jalr	-1182(ra) # 802017c0 <_ZN11hello_world9hyp_alloc15frame_allocator8PhysAddr5floor17hf7c65c16de669814E>
    80203c66:	f0843583          	ld	a1,-248(s0)
    80203c6a:	862a                	mv	a2,a0
    80203c6c:	f1043503          	ld	a0,-240(s0)
    80203c70:	ffffe097          	auipc	ra,0xffffe
    80203c74:	bec080e7          	jalr	-1044(ra) # 8020185c <_ZN11hello_world9hyp_alloc15frame_allocator19StackFrameAllocator4init17hdf2368df4d84172dE>
    80203c78:	f4043503          	ld	a0,-192(s0)
    80203c7c:	f6a43c23          	sd	a0,-136(s0)
    80203c80:	f3843503          	ld	a0,-200(s0)
    80203c84:	f6a43823          	sd	a0,-144(s0)
    80203c88:	f3043503          	ld	a0,-208(s0)
    80203c8c:	f6a43423          	sd	a0,-152(s0)
    80203c90:	f2843503          	ld	a0,-216(s0)
    80203c94:	f6a43023          	sd	a0,-160(s0)
    80203c98:	f2043503          	ld	a0,-224(s0)
    80203c9c:	f4a43c23          	sd	a0,-168(s0)
    80203ca0:	4501                	li	a0,0
    80203ca2:	00000097          	auipc	ra,0x0
    80203ca6:	a3e080e7          	jalr	-1474(ra) # 802036e0 <_ZN4core4sync6atomic10AtomicBool3new17h6d6eeb31741e1d39E>
    80203caa:	f1843583          	ld	a1,-232(s0)
    80203cae:	fea407a3          	sb	a0,-17(s0)
    80203cb2:	fef40503          	lb	a0,-17(s0)
    80203cb6:	faa40c23          	sb	a0,-72(s0)
    80203cba:	f7843503          	ld	a0,-136(s0)
    80203cbe:	fea43023          	sd	a0,-32(s0)
    80203cc2:	f7043503          	ld	a0,-144(s0)
    80203cc6:	fca43c23          	sd	a0,-40(s0)
    80203cca:	f6843503          	ld	a0,-152(s0)
    80203cce:	fca43823          	sd	a0,-48(s0)
    80203cd2:	f6043503          	ld	a0,-160(s0)
    80203cd6:	fca43423          	sd	a0,-56(s0)
    80203cda:	f5843503          	ld	a0,-168(s0)
    80203cde:	fca43023          	sd	a0,-64(s0)
    80203ce2:	fb840503          	lb	a0,-72(s0)
    80203ce6:	f8a40423          	sb	a0,-120(s0)
    80203cea:	fe043503          	ld	a0,-32(s0)
    80203cee:	faa43823          	sd	a0,-80(s0)
    80203cf2:	fd843503          	ld	a0,-40(s0)
    80203cf6:	faa43423          	sd	a0,-88(s0)
    80203cfa:	fd043503          	ld	a0,-48(s0)
    80203cfe:	faa43023          	sd	a0,-96(s0)
    80203d02:	fc843503          	ld	a0,-56(s0)
    80203d06:	f8a43c23          	sd	a0,-104(s0)
    80203d0a:	fc043503          	ld	a0,-64(s0)
    80203d0e:	f8a43823          	sd	a0,-112(s0)
    80203d12:	fb043503          	ld	a0,-80(s0)
    80203d16:	f588                	sd	a0,40(a1)
    80203d18:	fa843503          	ld	a0,-88(s0)
    80203d1c:	f188                	sd	a0,32(a1)
    80203d1e:	fa043503          	ld	a0,-96(s0)
    80203d22:	ed88                	sd	a0,24(a1)
    80203d24:	f9843503          	ld	a0,-104(s0)
    80203d28:	e988                	sd	a0,16(a1)
    80203d2a:	f9043503          	ld	a0,-112(s0)
    80203d2e:	e588                	sd	a0,8(a1)
    80203d30:	f8843503          	ld	a0,-120(s0)
    80203d34:	e188                	sd	a0,0(a1)
    80203d36:	70ee                	ld	ra,248(sp)
    80203d38:	744e                	ld	s0,240(sp)
    80203d3a:	6111                	add	sp,sp,256
    80203d3c:	8082                	ret

0000000080203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>:
    80203d3e:	1141                	add	sp,sp,-16
    80203d40:	e406                	sd	ra,8(sp)
    80203d42:	e022                	sd	s0,0(sp)
    80203d44:	0800                	add	s0,sp,16
    80203d46:	4501                	li	a0,0
    80203d48:	60a2                	ld	ra,8(sp)
    80203d4a:	6402                	ld	s0,0(sp)
    80203d4c:	0141                	add	sp,sp,16
    80203d4e:	8082                	ret

0000000080203d50 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$10trap_cause17h5ef68bfd5dbe7c2cE>:
    80203d50:	1101                	add	sp,sp,-32
    80203d52:	ec06                	sd	ra,24(sp)
    80203d54:	e822                	sd	s0,16(sp)
    80203d56:	1000                	add	s0,sp,32
    80203d58:	85aa                	mv	a1,a0
    80203d5a:	feb43423          	sd	a1,-24(s0)
    80203d5e:	2d058503          	lb	a0,720(a1)
    80203d62:	2d158583          	lb	a1,721(a1)
    80203d66:	60e2                	ld	ra,24(sp)
    80203d68:	6442                	ld	s0,16(sp)
    80203d6a:	6105                	add	sp,sp,32
    80203d6c:	8082                	ret

0000000080203d6e <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$3run17had6912c16d3d39a0E>:
    80203d6e:	7139                	add	sp,sp,-64
    80203d70:	fc06                	sd	ra,56(sp)
    80203d72:	f822                	sd	s0,48(sp)
    80203d74:	0080                	add	s0,sp,64
    80203d76:	fca43023          	sd	a0,-64(s0)
    80203d7a:	fea43023          	sd	a0,-32(s0)
    80203d7e:	a009                	j	80203d80 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$3run17had6912c16d3d39a0E+0x12>
    80203d80:	fc043503          	ld	a0,-64(s0)
    80203d84:	fea43423          	sd	a0,-24(s0)
    80203d88:	00001097          	auipc	ra,0x1
    80203d8c:	0cc080e7          	jalr	204(ra) # 80204e54 <_run_guest>
    80203d90:	ffffe097          	auipc	ra,0xffffe
    80203d94:	e36080e7          	jalr	-458(ra) # 80201bc6 <_ZN5riscv8register6scause4read17hc4ef42e3f7fd8211E>
    80203d98:	fca43423          	sd	a0,-56(s0)
    80203d9c:	fc840513          	add	a0,s0,-56
    80203da0:	ffffe097          	auipc	ra,0xffffe
    80203da4:	eec080e7          	jalr	-276(ra) # 80201c8c <_ZN5riscv8register6scause6Scause4bits17hdcefc3e6f2c3c097E>
    80203da8:	fc043583          	ld	a1,-64(s0)
    80203dac:	2aa5b823          	sd	a0,688(a1)
    80203db0:	00000097          	auipc	ra,0x0
    80203db4:	1ba080e7          	jalr	442(ra) # 80203f6a <_ZN5riscv8register5stval4read17hbabc8807415afe53E>
    80203db8:	fc043583          	ld	a1,-64(s0)
    80203dbc:	2aa5bc23          	sd	a0,696(a1)
    80203dc0:	fffff097          	auipc	ra,0xfffff
    80203dc4:	50e080e7          	jalr	1294(ra) # 802032ce <_ZN5riscv8register13hypervisorx645htval4read17hc57b67ab40213a91E>
    80203dc8:	fc043583          	ld	a1,-64(s0)
    80203dcc:	2ca5b023          	sd	a0,704(a1)
    80203dd0:	00000097          	auipc	ra,0x0
    80203dd4:	142080e7          	jalr	322(ra) # 80203f12 <_ZN5riscv8register13hypervisorx646htinst4read17h07612530a0f21e51E>
    80203dd8:	fc043583          	ld	a1,-64(s0)
    80203ddc:	2ca5b423          	sd	a0,712(a1)
    80203de0:	ffffe097          	auipc	ra,0xffffe
    80203de4:	de6080e7          	jalr	-538(ra) # 80201bc6 <_ZN5riscv8register6scause4read17hc4ef42e3f7fd8211E>
    80203de8:	fca43c23          	sd	a0,-40(s0)
    80203dec:	fd840513          	add	a0,s0,-40
    80203df0:	ffffe097          	auipc	ra,0xffffe
    80203df4:	eb2080e7          	jalr	-334(ra) # 80201ca2 <_ZN5riscv8register6scause6Scause5cause17hcca0344914ed6fa1E>
    80203df8:	862a                	mv	a2,a0
    80203dfa:	fc043503          	ld	a0,-64(s0)
    80203dfe:	8a05                	and	a2,a2,1
    80203e00:	fcc40823          	sb	a2,-48(s0)
    80203e04:	fcb408a3          	sb	a1,-47(s0)
    80203e08:	fd040603          	lb	a2,-48(s0)
    80203e0c:	fd140583          	lb	a1,-47(s0)
    80203e10:	2cc50823          	sb	a2,720(a0)
    80203e14:	2cb508a3          	sb	a1,721(a0)
    80203e18:	00000097          	auipc	ra,0x0
    80203e1c:	a4e080e7          	jalr	-1458(ra) # 80203866 <_ZN81_$LT$hello_world..HyperCraftHalImpl$u20$as$u20$hypercraft..hal..HyperCraftHal$GT$14vmexit_handler17h8e7820c02ec1aa70E>
    80203e20:	b785                	j	80203d80 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$3run17had6912c16d3d39a0E+0x12>

0000000080203e22 <_ZN10hypercraft4arch4vcpu13VCpu$LT$H$GT$6create17h95ac8a1e9e575535E>:
    80203e22:	9e010113          	add	sp,sp,-1568
    80203e26:	60113c23          	sd	ra,1560(sp)
    80203e2a:	60813823          	sd	s0,1552(sp)
    80203e2e:	62010413          	add	s0,sp,1568
    80203e32:	a0b43423          	sd	a1,-1528(s0)
    80203e36:	a2a43023          	sd	a0,-1504(s0)
    80203e3a:	feb43023          	sd	a1,-32(s0)
    80203e3e:	a2840513          	add	a0,s0,-1496
    80203e42:	a0a43023          	sd	a0,-1536(s0)
    80203e46:	00000097          	auipc	ra,0x0
    80203e4a:	4d0080e7          	jalr	1232(ra) # 80204316 <_ZN81_$LT$hypercraft..arch..vcpu..VmCpuRegisters$u20$as$u20$core..default..Default$GT$7default17h644e23ee3704cb92E>
    80203e4e:	fffff097          	auipc	ra,0xfffff
    80203e52:	402080e7          	jalr	1026(ra) # 80203250 <_ZN5riscv8register13hypervisorx647hstatus4read17hfae6f9138d080d16E>
    80203e56:	cea43c23          	sd	a0,-776(s0)
    80203e5a:	cf840513          	add	a0,s0,-776
    80203e5e:	9ea43423          	sd	a0,-1560(s0)
    80203e62:	4585                	li	a1,1
    80203e64:	9eb43823          	sd	a1,-1552(s0)
    80203e68:	fffff097          	auipc	ra,0xfffff
    80203e6c:	43a080e7          	jalr	1082(ra) # 802032a2 <_ZN5riscv8register13hypervisorx647hstatus7Hstatus7set_spv17h9293b26d4ce9221cE>
    80203e70:	9e843503          	ld	a0,-1560(s0)
    80203e74:	fffff097          	auipc	ra,0xfffff
    80203e78:	418080e7          	jalr	1048(ra) # 8020328c <_ZN5riscv8register13hypervisorx647hstatus7Hstatus4bits17hdccc00d3ae634d4eE>
    80203e7c:	c4a43c23          	sd	a0,-936(s0)
    80203e80:	ffffe097          	auipc	ra,0xffffe
    80203e84:	78c080e7          	jalr	1932(ra) # 8020260c <_ZN5riscv8register7sstatus4read17h474c3adc66f37ec2E>
    80203e88:	9f043583          	ld	a1,-1552(s0)
    80203e8c:	d0a43023          	sd	a0,-768(s0)
    80203e90:	d0040513          	add	a0,s0,-768
    80203e94:	9ea43c23          	sd	a0,-1544(s0)
    80203e98:	ffffe097          	auipc	ra,0xffffe
    80203e9c:	7c6080e7          	jalr	1990(ra) # 8020265e <_ZN5riscv8register7sstatus7Sstatus7set_spp17h4623bbd2c56ae136E>
    80203ea0:	9f843503          	ld	a0,-1544(s0)
    80203ea4:	ffffe097          	auipc	ra,0xffffe
    80203ea8:	7a4080e7          	jalr	1956(ra) # 80202648 <_ZN5riscv8register7sstatus7Sstatus4bits17h8ffdaa3b08d0261cE>
    80203eac:	a0043583          	ld	a1,-1536(s0)
    80203eb0:	862a                	mv	a2,a0
    80203eb2:	a0843503          	ld	a0,-1528(s0)
    80203eb6:	c4c43823          	sd	a2,-944(s0)
    80203eba:	c6a43423          	sd	a0,-920(s0)
    80203ebe:	d0840513          	add	a0,s0,-760
    80203ec2:	a0a43823          	sd	a0,-1520(s0)
    80203ec6:	2d000613          	li	a2,720
    80203eca:	a0c43c23          	sd	a2,-1512(s0)
    80203ece:	00003097          	auipc	ra,0x3
    80203ed2:	996080e7          	jalr	-1642(ra) # 80206864 <memcpy>
    80203ed6:	a1043583          	ld	a1,-1520(s0)
    80203eda:	a1843603          	ld	a2,-1512(s0)
    80203ede:	a2043503          	ld	a0,-1504(s0)
    80203ee2:	4689                	li	a3,2
    80203ee4:	fcd40c23          	sb	a3,-40(s0)
    80203ee8:	00003097          	auipc	ra,0x3
    80203eec:	97c080e7          	jalr	-1668(ra) # 80206864 <memcpy>
    80203ef0:	a2043583          	ld	a1,-1504(s0)
    80203ef4:	fd840603          	lb	a2,-40(s0)
    80203ef8:	fd940503          	lb	a0,-39(s0)
    80203efc:	2cc58823          	sb	a2,720(a1)
    80203f00:	2ca588a3          	sb	a0,721(a1)
    80203f04:	61813083          	ld	ra,1560(sp)
    80203f08:	61013403          	ld	s0,1552(sp)
    80203f0c:	62010113          	add	sp,sp,1568
    80203f10:	8082                	ret

0000000080203f12 <_ZN5riscv8register13hypervisorx646htinst4read17h07612530a0f21e51E>:
    80203f12:	1141                	add	sp,sp,-16
    80203f14:	e406                	sd	ra,8(sp)
    80203f16:	e022                	sd	s0,0(sp)
    80203f18:	0800                	add	s0,sp,16
    80203f1a:	00000097          	auipc	ra,0x0
    80203f1e:	010080e7          	jalr	16(ra) # 80203f2a <_ZN5riscv8register13hypervisorx646htinst5_read17hb82f813141c8977fE>
    80203f22:	60a2                	ld	ra,8(sp)
    80203f24:	6402                	ld	s0,0(sp)
    80203f26:	0141                	add	sp,sp,16
    80203f28:	8082                	ret

0000000080203f2a <_ZN5riscv8register13hypervisorx646htinst5_read17hb82f813141c8977fE>:
    80203f2a:	1101                	add	sp,sp,-32
    80203f2c:	ec06                	sd	ra,24(sp)
    80203f2e:	e822                	sd	s0,16(sp)
    80203f30:	1000                	add	s0,sp,32
    80203f32:	64a02573          	csrr	a0,htinst
    80203f36:	fea43423          	sd	a0,-24(s0)
    80203f3a:	fe843503          	ld	a0,-24(s0)
    80203f3e:	60e2                	ld	ra,24(sp)
    80203f40:	6442                	ld	s0,16(sp)
    80203f42:	6105                	add	sp,sp,32
    80203f44:	8082                	ret

0000000080203f46 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4fill17hc24eb31986d1989aE>:
    80203f46:	7179                	add	sp,sp,-48
    80203f48:	f406                	sd	ra,40(sp)
    80203f4a:	f022                	sd	s0,32(sp)
    80203f4c:	1800                	add	s0,sp,48
    80203f4e:	fca43c23          	sd	a0,-40(s0)
    80203f52:	feb43023          	sd	a1,-32(s0)
    80203f56:	fec407a3          	sb	a2,-17(s0)
    80203f5a:	fffff097          	auipc	ra,0xfffff
    80203f5e:	534080e7          	jalr	1332(ra) # 8020348e <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17hcfdc96a5d38b6a4fE>
    80203f62:	70a2                	ld	ra,40(sp)
    80203f64:	7402                	ld	s0,32(sp)
    80203f66:	6145                	add	sp,sp,48
    80203f68:	8082                	ret

0000000080203f6a <_ZN5riscv8register5stval4read17hbabc8807415afe53E>:
    80203f6a:	1141                	add	sp,sp,-16
    80203f6c:	e406                	sd	ra,8(sp)
    80203f6e:	e022                	sd	s0,0(sp)
    80203f70:	0800                	add	s0,sp,16
    80203f72:	00000097          	auipc	ra,0x0
    80203f76:	010080e7          	jalr	16(ra) # 80203f82 <_ZN5riscv8register5stval5_read17he7279c74f5ca31bfE>
    80203f7a:	60a2                	ld	ra,8(sp)
    80203f7c:	6402                	ld	s0,0(sp)
    80203f7e:	0141                	add	sp,sp,16
    80203f80:	8082                	ret

0000000080203f82 <_ZN5riscv8register5stval5_read17he7279c74f5ca31bfE>:
    80203f82:	1101                	add	sp,sp,-32
    80203f84:	ec06                	sd	ra,24(sp)
    80203f86:	e822                	sd	s0,16(sp)
    80203f88:	1000                	add	s0,sp,32
    80203f8a:	14302573          	csrr	a0,stval
    80203f8e:	fea43423          	sd	a0,-24(s0)
    80203f92:	fe843503          	ld	a0,-24(s0)
    80203f96:	60e2                	ld	ra,24(sp)
    80203f98:	6442                	ld	s0,16(sp)
    80203f9a:	6105                	add	sp,sp,32
    80203f9c:	8082                	ret

0000000080203f9e <_ZN6sbi_rt4srst12system_reset17he21f6bcec193366cE>:
    80203f9e:	7159                	add	sp,sp,-112
    80203fa0:	f486                	sd	ra,104(sp)
    80203fa2:	f0a2                	sd	s0,96(sp)
    80203fa4:	1880                	add	s0,sp,112
    80203fa6:	fa040513          	add	a0,s0,-96
    80203faa:	ffffe097          	auipc	ra,0xffffe
    80203fae:	d6c080e7          	jalr	-660(ra) # 80201d16 <_ZN66_$LT$sbi_rt..srst..Shutdown$u20$as$u20$sbi_rt..srst..ResetType$GT$3raw17he7adfdcc96af6bb3E>
    80203fb2:	1502                	sll	a0,a0,0x20
    80203fb4:	9101                	srl	a0,a0,0x20
    80203fb6:	f8a43c23          	sd	a0,-104(s0)
    80203fba:	fa840513          	add	a0,s0,-88
    80203fbe:	ffffe097          	auipc	ra,0xffffe
    80203fc2:	d6e080e7          	jalr	-658(ra) # 80201d2c <_ZN73_$LT$sbi_rt..srst..SystemFailure$u20$as$u20$sbi_rt..srst..ResetReason$GT$3raw17hef946130f5113183E>
    80203fc6:	85aa                	mv	a1,a0
    80203fc8:	f9843503          	ld	a0,-104(s0)
    80203fcc:	1582                	sll	a1,a1,0x20
    80203fce:	9181                	srl	a1,a1,0x20
    80203fd0:	53525637          	lui	a2,0x53525
    80203fd4:	3546089b          	addw	a7,a2,852 # 53525354 <.Lline_table_start0+0x534dfb0b>
    80203fd8:	fd143823          	sd	a7,-48(s0)
    80203fdc:	4801                	li	a6,0
    80203fde:	fd043c23          	sd	a6,-40(s0)
    80203fe2:	fea43023          	sd	a0,-32(s0)
    80203fe6:	feb43423          	sd	a1,-24(s0)
    80203fea:	00000073          	ecall
    80203fee:	fca43023          	sd	a0,-64(s0)
    80203ff2:	fcb43423          	sd	a1,-56(s0)
    80203ff6:	fc043583          	ld	a1,-64(s0)
    80203ffa:	fc843503          	ld	a0,-56(s0)
    80203ffe:	fab43823          	sd	a1,-80(s0)
    80204002:	faa43c23          	sd	a0,-72(s0)
    80204006:	fb043503          	ld	a0,-80(s0)
    8020400a:	fb843583          	ld	a1,-72(s0)
    8020400e:	70a6                	ld	ra,104(sp)
    80204010:	7406                	ld	s0,96(sp)
    80204012:	6165                	add	sp,sp,112
    80204014:	8082                	ret

0000000080204016 <_ZN4core5slice3raw18from_raw_parts_mut17h14a1da24eb7f929aE>:
    80204016:	715d                	add	sp,sp,-80
    80204018:	e486                	sd	ra,72(sp)
    8020401a:	e0a2                	sd	s0,64(sp)
    8020401c:	0880                	add	s0,sp,80
    8020401e:	fca43c23          	sd	a0,-40(s0)
    80204022:	feb43023          	sd	a1,-32(s0)
    80204026:	fea43423          	sd	a0,-24(s0)
    8020402a:	fca43423          	sd	a0,-56(s0)
    8020402e:	fcb43823          	sd	a1,-48(s0)
    80204032:	fc843583          	ld	a1,-56(s0)
    80204036:	fd043503          	ld	a0,-48(s0)
    8020403a:	fab43c23          	sd	a1,-72(s0)
    8020403e:	fca43023          	sd	a0,-64(s0)
    80204042:	fb843503          	ld	a0,-72(s0)
    80204046:	fc043583          	ld	a1,-64(s0)
    8020404a:	60a6                	ld	ra,72(sp)
    8020404c:	6406                	ld	s0,64(sp)
    8020404e:	6161                	add	sp,sp,80
    80204050:	8082                	ret

0000000080204052 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17h8eb8d1e0f938bd7cE>:
    80204052:	7139                	add	sp,sp,-64
    80204054:	fc06                	sd	ra,56(sp)
    80204056:	f822                	sd	s0,48(sp)
    80204058:	0080                	add	s0,sp,64
    8020405a:	fcc43423          	sd	a2,-56(s0)
    8020405e:	fcb43823          	sd	a1,-48(s0)
    80204062:	fca43c23          	sd	a0,-40(s0)
    80204066:	fea43023          	sd	a0,-32(s0)
    8020406a:	feb43423          	sd	a1,-24(s0)
    8020406e:	03f00513          	li	a0,63
    80204072:	00b56f63          	bltu	a0,a1,80204090 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17h8eb8d1e0f938bd7cE+0x3e>
    80204076:	a009                	j	80204078 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17h8eb8d1e0f938bd7cE+0x26>
    80204078:	fd043503          	ld	a0,-48(s0)
    8020407c:	fd843583          	ld	a1,-40(s0)
    80204080:	618c                	ld	a1,0(a1)
    80204082:	fcb43023          	sd	a1,-64(s0)
    80204086:	04000593          	li	a1,64
    8020408a:	02b56063          	bltu	a0,a1,802040aa <.Lpcrel_hi0+0x16>
    8020408e:	a80d                	j	802040c0 <.Lpcrel_hi0+0x2c>
    80204090:	fc843603          	ld	a2,-56(s0)

0000000080204094 <.Lpcrel_hi0>:
    80204094:	00004517          	auipc	a0,0x4
    80204098:	acc50513          	add	a0,a0,-1332 # 80207b60 <.L__unnamed_1>
    8020409c:	02800593          	li	a1,40
    802040a0:	00001097          	auipc	ra,0x1
    802040a4:	4ba080e7          	jalr	1210(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802040a8:	0000                	unimp
    802040aa:	fc043503          	ld	a0,-64(s0)
    802040ae:	fd043583          	ld	a1,-48(s0)
    802040b2:	00b55533          	srl	a0,a0,a1
    802040b6:	8905                	and	a0,a0,1
    802040b8:	70e2                	ld	ra,56(sp)
    802040ba:	7442                	ld	s0,48(sp)
    802040bc:	6121                	add	sp,sp,64
    802040be:	8082                	ret
    802040c0:	fc843603          	ld	a2,-56(s0)

00000000802040c4 <.Lpcrel_hi1>:
    802040c4:	00004517          	auipc	a0,0x4
    802040c8:	acc50513          	add	a0,a0,-1332 # 80207b90 <str.0>
    802040cc:	02300593          	li	a1,35
    802040d0:	00001097          	auipc	ra,0x1
    802040d4:	48a080e7          	jalr	1162(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

00000000802040da <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17h27dfc59eebaa642fE>:
    802040da:	715d                	add	sp,sp,-80
    802040dc:	e486                	sd	ra,72(sp)
    802040de:	e0a2                	sd	s0,64(sp)
    802040e0:	0880                	add	s0,sp,80
    802040e2:	fad43c23          	sd	a3,-72(s0)
    802040e6:	fcb43023          	sd	a1,-64(s0)
    802040ea:	fca43423          	sd	a0,-56(s0)
    802040ee:	86b2                	mv	a3,a2
    802040f0:	fcd43823          	sd	a3,-48(s0)
    802040f4:	fca43c23          	sd	a0,-40(s0)
    802040f8:	feb43023          	sd	a1,-32(s0)
    802040fc:	fec407a3          	sb	a2,-17(s0)
    80204100:	03f00513          	li	a0,63
    80204104:	00b56863          	bltu	a0,a1,80204114 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17h27dfc59eebaa642fE+0x3a>
    80204108:	a009                	j	8020410a <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17h27dfc59eebaa642fE+0x30>
    8020410a:	fd043503          	ld	a0,-48(s0)
    8020410e:	8905                	and	a0,a0,1
    80204110:	e515                	bnez	a0,8020413c <.Lpcrel_hi2+0x24>
    80204112:	a831                	j	8020412e <.Lpcrel_hi2+0x16>
    80204114:	fb843603          	ld	a2,-72(s0)

0000000080204118 <.Lpcrel_hi2>:
    80204118:	00004517          	auipc	a0,0x4
    8020411c:	a4850513          	add	a0,a0,-1464 # 80207b60 <.L__unnamed_1>
    80204120:	02800593          	li	a1,40
    80204124:	00001097          	auipc	ra,0x1
    80204128:	436080e7          	jalr	1078(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    8020412c:	0000                	unimp
    8020412e:	fc043503          	ld	a0,-64(s0)
    80204132:	04000593          	li	a1,64
    80204136:	04b56863          	bltu	a0,a1,80204186 <.Lpcrel_hi3+0x22>
    8020413a:	a09d                	j	802041a0 <.Lpcrel_hi3+0x3c>
    8020413c:	fc043583          	ld	a1,-64(s0)
    80204140:	03f00513          	li	a0,63
    80204144:	00b56e63          	bltu	a0,a1,80204160 <.Lpcrel_hi2+0x48>
    80204148:	a009                	j	8020414a <.Lpcrel_hi2+0x32>
    8020414a:	fc843583          	ld	a1,-56(s0)
    8020414e:	fc043603          	ld	a2,-64(s0)
    80204152:	4505                	li	a0,1
    80204154:	00c51633          	sll	a2,a0,a2
    80204158:	6188                	ld	a0,0(a1)
    8020415a:	8d51                	or	a0,a0,a2
    8020415c:	e188                	sd	a0,0(a1)
    8020415e:	a831                	j	8020417a <.Lpcrel_hi3+0x16>
    80204160:	fb843603          	ld	a2,-72(s0)

0000000080204164 <.Lpcrel_hi3>:
    80204164:	00004517          	auipc	a0,0x4
    80204168:	a2c50513          	add	a0,a0,-1492 # 80207b90 <str.0>
    8020416c:	02300593          	li	a1,35
    80204170:	00001097          	auipc	ra,0x1
    80204174:	3ea080e7          	jalr	1002(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204178:	0000                	unimp
    8020417a:	fc843503          	ld	a0,-56(s0)
    8020417e:	60a6                	ld	ra,72(sp)
    80204180:	6406                	ld	s0,64(sp)
    80204182:	6161                	add	sp,sp,80
    80204184:	8082                	ret
    80204186:	fc843583          	ld	a1,-56(s0)
    8020418a:	fc043603          	ld	a2,-64(s0)
    8020418e:	4505                	li	a0,1
    80204190:	00c51533          	sll	a0,a0,a2
    80204194:	fff54613          	not	a2,a0
    80204198:	6188                	ld	a0,0(a1)
    8020419a:	8d71                	and	a0,a0,a2
    8020419c:	e188                	sd	a0,0(a1)
    8020419e:	bff1                	j	8020417a <.Lpcrel_hi3+0x16>
    802041a0:	fb843603          	ld	a2,-72(s0)

00000000802041a4 <.Lpcrel_hi4>:
    802041a4:	00004517          	auipc	a0,0x4
    802041a8:	9ec50513          	add	a0,a0,-1556 # 80207b90 <str.0>
    802041ac:	02300593          	li	a1,35
    802041b0:	00001097          	auipc	ra,0x1
    802041b4:	3aa080e7          	jalr	938(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

00000000802041ba <_ZN78_$LT$hypercraft..arch..vcpu..GuestVsCsrs$u20$as$u20$core..default..Default$GT$7default17hc6aab9a0df988583E>:
    802041ba:	711d                	add	sp,sp,-96
    802041bc:	ec86                	sd	ra,88(sp)
    802041be:	e8a2                	sd	s0,80(sp)
    802041c0:	1080                	add	s0,sp,96
    802041c2:	fea43423          	sd	a0,-24(s0)
    802041c6:	00000097          	auipc	ra,0x0
    802041ca:	b78080e7          	jalr	-1160(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802041ce:	faa43023          	sd	a0,-96(s0)
    802041d2:	00000097          	auipc	ra,0x0
    802041d6:	b6c080e7          	jalr	-1172(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802041da:	faa43423          	sd	a0,-88(s0)
    802041de:	00000097          	auipc	ra,0x0
    802041e2:	b60080e7          	jalr	-1184(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802041e6:	faa43823          	sd	a0,-80(s0)
    802041ea:	00000097          	auipc	ra,0x0
    802041ee:	b54080e7          	jalr	-1196(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802041f2:	faa43c23          	sd	a0,-72(s0)
    802041f6:	00000097          	auipc	ra,0x0
    802041fa:	b48080e7          	jalr	-1208(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802041fe:	fca43023          	sd	a0,-64(s0)
    80204202:	00000097          	auipc	ra,0x0
    80204206:	b3c080e7          	jalr	-1220(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020420a:	fca43423          	sd	a0,-56(s0)
    8020420e:	00000097          	auipc	ra,0x0
    80204212:	b30080e7          	jalr	-1232(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204216:	fca43823          	sd	a0,-48(s0)
    8020421a:	00000097          	auipc	ra,0x0
    8020421e:	b24080e7          	jalr	-1244(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204222:	fca43c23          	sd	a0,-40(s0)
    80204226:	00000097          	auipc	ra,0x0
    8020422a:	b18080e7          	jalr	-1256(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020422e:	fea43023          	sd	a0,-32(s0)
    80204232:	00000097          	auipc	ra,0x0
    80204236:	b0c080e7          	jalr	-1268(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020423a:	fa043383          	ld	t2,-96(s0)
    8020423e:	fa843303          	ld	t1,-88(s0)
    80204242:	fb043283          	ld	t0,-80(s0)
    80204246:	fb843883          	ld	a7,-72(s0)
    8020424a:	fc043803          	ld	a6,-64(s0)
    8020424e:	fc843783          	ld	a5,-56(s0)
    80204252:	fd043703          	ld	a4,-48(s0)
    80204256:	fd843683          	ld	a3,-40(s0)
    8020425a:	fe043603          	ld	a2,-32(s0)
    8020425e:	fe843583          	ld	a1,-24(s0)
    80204262:	0075b023          	sd	t2,0(a1)
    80204266:	0065b423          	sd	t1,8(a1)
    8020426a:	0055b823          	sd	t0,16(a1)
    8020426e:	0115bc23          	sd	a7,24(a1)
    80204272:	0305b023          	sd	a6,32(a1)
    80204276:	f59c                	sd	a5,40(a1)
    80204278:	f998                	sd	a4,48(a1)
    8020427a:	fd94                	sd	a3,56(a1)
    8020427c:	e1b0                	sd	a2,64(a1)
    8020427e:	e5a8                	sd	a0,72(a1)
    80204280:	60e6                	ld	ra,88(sp)
    80204282:	6446                	ld	s0,80(sp)
    80204284:	6125                	add	sp,sp,96
    80204286:	8082                	ret

0000000080204288 <_ZN80_$LT$hypercraft..arch..vcpu..GuestCpuState$u20$as$u20$core..default..Default$GT$7default17ha0b1f811ec64859bE>:
    80204288:	7129                	add	sp,sp,-320
    8020428a:	fe06                	sd	ra,312(sp)
    8020428c:	fa22                	sd	s0,304(sp)
    8020428e:	0280                	add	s0,sp,320
    80204290:	eea43023          	sd	a0,-288(s0)
    80204294:	ef040513          	add	a0,s0,-272
    80204298:	eca43023          	sd	a0,-320(s0)
    8020429c:	ffffd097          	auipc	ra,0xffffd
    802042a0:	ea0080e7          	jalr	-352(ra) # 8020113c <_ZN90_$LT$hypercraft..arch..regs..GeneralPurposeRegisters$u20$as$u20$core..default..Default$GT$7default17h3fb5b412bc55897aE>
    802042a4:	00000097          	auipc	ra,0x0
    802042a8:	a9a080e7          	jalr	-1382(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802042ac:	eca43423          	sd	a0,-312(s0)
    802042b0:	00000097          	auipc	ra,0x0
    802042b4:	a8e080e7          	jalr	-1394(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802042b8:	eca43823          	sd	a0,-304(s0)
    802042bc:	00000097          	auipc	ra,0x0
    802042c0:	a82080e7          	jalr	-1406(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802042c4:	eca43c23          	sd	a0,-296(s0)
    802042c8:	00000097          	auipc	ra,0x0
    802042cc:	a76080e7          	jalr	-1418(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802042d0:	ec043583          	ld	a1,-320(s0)
    802042d4:	862a                	mv	a2,a0
    802042d6:	ee043503          	ld	a0,-288(s0)
    802042da:	eec43423          	sd	a2,-280(s0)
    802042de:	10000613          	li	a2,256
    802042e2:	00002097          	auipc	ra,0x2
    802042e6:	582080e7          	jalr	1410(ra) # 80206864 <memcpy>
    802042ea:	ec843703          	ld	a4,-312(s0)
    802042ee:	ed043683          	ld	a3,-304(s0)
    802042f2:	ed843603          	ld	a2,-296(s0)
    802042f6:	ee043583          	ld	a1,-288(s0)
    802042fa:	ee843503          	ld	a0,-280(s0)
    802042fe:	10e5b023          	sd	a4,256(a1)
    80204302:	10d5b423          	sd	a3,264(a1)
    80204306:	10c5b823          	sd	a2,272(a1)
    8020430a:	10a5bc23          	sd	a0,280(a1)
    8020430e:	70f2                	ld	ra,312(sp)
    80204310:	7452                	ld	s0,304(sp)
    80204312:	6131                	add	sp,sp,320
    80204314:	8082                	ret

0000000080204316 <_ZN81_$LT$hypercraft..arch..vcpu..VmCpuRegisters$u20$as$u20$core..default..Default$GT$7default17h644e23ee3704cb92E>:
    80204316:	d0010113          	add	sp,sp,-768
    8020431a:	2e113c23          	sd	ra,760(sp)
    8020431e:	2e813823          	sd	s0,752(sp)
    80204322:	0600                	add	s0,sp,768
    80204324:	d0a43c23          	sd	a0,-744(s0)
    80204328:	d2040513          	add	a0,s0,-736
    8020432c:	d0a43023          	sd	a0,-768(s0)
    80204330:	00000097          	auipc	ra,0x0
    80204334:	16c080e7          	jalr	364(ra) # 8020449c <_ZN85_$LT$hypercraft..arch..vcpu..HypervisorCpuState$u20$as$u20$core..default..Default$GT$7default17h8147356628b70738E>
    80204338:	e4840513          	add	a0,s0,-440
    8020433c:	d0a43423          	sd	a0,-760(s0)
    80204340:	00000097          	auipc	ra,0x0
    80204344:	f48080e7          	jalr	-184(ra) # 80204288 <_ZN80_$LT$hypercraft..arch..vcpu..GuestCpuState$u20$as$u20$core..default..Default$GT$7default17ha0b1f811ec64859bE>
    80204348:	f6840513          	add	a0,s0,-152
    8020434c:	d0a43823          	sd	a0,-752(s0)
    80204350:	00000097          	auipc	ra,0x0
    80204354:	e6a080e7          	jalr	-406(ra) # 802041ba <_ZN78_$LT$hypercraft..arch..vcpu..GuestVsCsrs$u20$as$u20$core..default..Default$GT$7default17hc6aab9a0df988583E>
    80204358:	fb840513          	add	a0,s0,-72
    8020435c:	00000097          	auipc	ra,0x0
    80204360:	0fa080e7          	jalr	250(ra) # 80204456 <_ZN85_$LT$hypercraft..arch..vcpu..GuestVirtualHsCsrs$u20$as$u20$core..default..Default$GT$7default17h4bedab2e911a15edE>
    80204364:	fd040513          	add	a0,s0,-48
    80204368:	00000097          	auipc	ra,0x0
    8020436c:	096080e7          	jalr	150(ra) # 802043fe <_ZN81_$LT$hypercraft..arch..vcpu..VmCpuTrapState$u20$as$u20$core..default..Default$GT$7default17hbc2fcad362b58c3aE>
    80204370:	d0043583          	ld	a1,-768(s0)
    80204374:	d1843503          	ld	a0,-744(s0)
    80204378:	12800613          	li	a2,296
    8020437c:	00002097          	auipc	ra,0x2
    80204380:	4e8080e7          	jalr	1256(ra) # 80206864 <memcpy>
    80204384:	d0843583          	ld	a1,-760(s0)
    80204388:	d1843503          	ld	a0,-744(s0)
    8020438c:	12850513          	add	a0,a0,296
    80204390:	12000613          	li	a2,288
    80204394:	00002097          	auipc	ra,0x2
    80204398:	4d0080e7          	jalr	1232(ra) # 80206864 <memcpy>
    8020439c:	d1043583          	ld	a1,-752(s0)
    802043a0:	d1843503          	ld	a0,-744(s0)
    802043a4:	24850513          	add	a0,a0,584
    802043a8:	05000613          	li	a2,80
    802043ac:	00002097          	auipc	ra,0x2
    802043b0:	4b8080e7          	jalr	1208(ra) # 80206864 <memcpy>
    802043b4:	d1843583          	ld	a1,-744(s0)
    802043b8:	fc843503          	ld	a0,-56(s0)
    802043bc:	2aa5b423          	sd	a0,680(a1)
    802043c0:	fc043503          	ld	a0,-64(s0)
    802043c4:	2aa5b023          	sd	a0,672(a1)
    802043c8:	fb843503          	ld	a0,-72(s0)
    802043cc:	28a5bc23          	sd	a0,664(a1)
    802043d0:	fe843503          	ld	a0,-24(s0)
    802043d4:	2ca5b423          	sd	a0,712(a1)
    802043d8:	fe043503          	ld	a0,-32(s0)
    802043dc:	2ca5b023          	sd	a0,704(a1)
    802043e0:	fd843503          	ld	a0,-40(s0)
    802043e4:	2aa5bc23          	sd	a0,696(a1)
    802043e8:	fd043503          	ld	a0,-48(s0)
    802043ec:	2aa5b823          	sd	a0,688(a1)
    802043f0:	2f813083          	ld	ra,760(sp)
    802043f4:	2f013403          	ld	s0,752(sp)
    802043f8:	30010113          	add	sp,sp,768
    802043fc:	8082                	ret

00000000802043fe <_ZN81_$LT$hypercraft..arch..vcpu..VmCpuTrapState$u20$as$u20$core..default..Default$GT$7default17hbc2fcad362b58c3aE>:
    802043fe:	7179                	add	sp,sp,-48
    80204400:	f406                	sd	ra,40(sp)
    80204402:	f022                	sd	s0,32(sp)
    80204404:	1800                	add	s0,sp,48
    80204406:	fea43423          	sd	a0,-24(s0)
    8020440a:	00000097          	auipc	ra,0x0
    8020440e:	934080e7          	jalr	-1740(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204412:	fca43823          	sd	a0,-48(s0)
    80204416:	00000097          	auipc	ra,0x0
    8020441a:	928080e7          	jalr	-1752(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020441e:	fca43c23          	sd	a0,-40(s0)
    80204422:	00000097          	auipc	ra,0x0
    80204426:	91c080e7          	jalr	-1764(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020442a:	fea43023          	sd	a0,-32(s0)
    8020442e:	00000097          	auipc	ra,0x0
    80204432:	910080e7          	jalr	-1776(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204436:	fd043703          	ld	a4,-48(s0)
    8020443a:	fd843683          	ld	a3,-40(s0)
    8020443e:	fe043603          	ld	a2,-32(s0)
    80204442:	fe843583          	ld	a1,-24(s0)
    80204446:	e198                	sd	a4,0(a1)
    80204448:	e594                	sd	a3,8(a1)
    8020444a:	e990                	sd	a2,16(a1)
    8020444c:	ed88                	sd	a0,24(a1)
    8020444e:	70a2                	ld	ra,40(sp)
    80204450:	7402                	ld	s0,32(sp)
    80204452:	6145                	add	sp,sp,48
    80204454:	8082                	ret

0000000080204456 <_ZN85_$LT$hypercraft..arch..vcpu..GuestVirtualHsCsrs$u20$as$u20$core..default..Default$GT$7default17h4bedab2e911a15edE>:
    80204456:	7179                	add	sp,sp,-48
    80204458:	f406                	sd	ra,40(sp)
    8020445a:	f022                	sd	s0,32(sp)
    8020445c:	1800                	add	s0,sp,48
    8020445e:	fea43423          	sd	a0,-24(s0)
    80204462:	00000097          	auipc	ra,0x0
    80204466:	8dc080e7          	jalr	-1828(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    8020446a:	fca43c23          	sd	a0,-40(s0)
    8020446e:	00000097          	auipc	ra,0x0
    80204472:	8d0080e7          	jalr	-1840(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204476:	fea43023          	sd	a0,-32(s0)
    8020447a:	00000097          	auipc	ra,0x0
    8020447e:	8c4080e7          	jalr	-1852(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    80204482:	fd843683          	ld	a3,-40(s0)
    80204486:	fe043603          	ld	a2,-32(s0)
    8020448a:	fe843583          	ld	a1,-24(s0)
    8020448e:	e194                	sd	a3,0(a1)
    80204490:	e590                	sd	a2,8(a1)
    80204492:	e988                	sd	a0,16(a1)
    80204494:	70a2                	ld	ra,40(sp)
    80204496:	7402                	ld	s0,32(sp)
    80204498:	6145                	add	sp,sp,48
    8020449a:	8082                	ret

000000008020449c <_ZN85_$LT$hypercraft..arch..vcpu..HypervisorCpuState$u20$as$u20$core..default..Default$GT$7default17h8147356628b70738E>:
    8020449c:	714d                	add	sp,sp,-336
    8020449e:	e686                	sd	ra,328(sp)
    802044a0:	e2a2                	sd	s0,320(sp)
    802044a2:	0a80                	add	s0,sp,336
    802044a4:	eea43023          	sd	a0,-288(s0)
    802044a8:	ef040513          	add	a0,s0,-272
    802044ac:	eaa43c23          	sd	a0,-328(s0)
    802044b0:	ffffd097          	auipc	ra,0xffffd
    802044b4:	c8c080e7          	jalr	-884(ra) # 8020113c <_ZN90_$LT$hypercraft..arch..regs..GeneralPurposeRegisters$u20$as$u20$core..default..Default$GT$7default17h3fb5b412bc55897aE>
    802044b8:	00000097          	auipc	ra,0x0
    802044bc:	886080e7          	jalr	-1914(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802044c0:	eca43023          	sd	a0,-320(s0)
    802044c4:	00000097          	auipc	ra,0x0
    802044c8:	87a080e7          	jalr	-1926(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802044cc:	eca43423          	sd	a0,-312(s0)
    802044d0:	00000097          	auipc	ra,0x0
    802044d4:	86e080e7          	jalr	-1938(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802044d8:	eca43823          	sd	a0,-304(s0)
    802044dc:	00000097          	auipc	ra,0x0
    802044e0:	862080e7          	jalr	-1950(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802044e4:	eca43c23          	sd	a0,-296(s0)
    802044e8:	00000097          	auipc	ra,0x0
    802044ec:	856080e7          	jalr	-1962(ra) # 80203d3e <_ZN46_$LT$u64$u20$as$u20$core..default..Default$GT$7default17hc0e9896e0888ab96E>
    802044f0:	eb843583          	ld	a1,-328(s0)
    802044f4:	862a                	mv	a2,a0
    802044f6:	ee043503          	ld	a0,-288(s0)
    802044fa:	eec43423          	sd	a2,-280(s0)
    802044fe:	10000613          	li	a2,256
    80204502:	00002097          	auipc	ra,0x2
    80204506:	362080e7          	jalr	866(ra) # 80206864 <memcpy>
    8020450a:	ec043783          	ld	a5,-320(s0)
    8020450e:	ec843703          	ld	a4,-312(s0)
    80204512:	ed043683          	ld	a3,-304(s0)
    80204516:	ed843603          	ld	a2,-296(s0)
    8020451a:	ee043583          	ld	a1,-288(s0)
    8020451e:	ee843503          	ld	a0,-280(s0)
    80204522:	10f5b023          	sd	a5,256(a1)
    80204526:	10e5b423          	sd	a4,264(a1)
    8020452a:	10d5b823          	sd	a3,272(a1)
    8020452e:	10c5bc23          	sd	a2,280(a1)
    80204532:	12a5b023          	sd	a0,288(a1)
    80204536:	60b6                	ld	ra,328(sp)
    80204538:	6416                	ld	s0,320(sp)
    8020453a:	6171                	add	sp,sp,336
    8020453c:	8082                	ret

000000008020453e <_ZN4core3fmt10ArgumentV113new_lower_hex17ha4c466433c3965dfE>:
    8020453e:	1101                	add	sp,sp,-32
    80204540:	85aa                	mv	a1,a0
    80204542:	e82e                	sd	a1,16(sp)

0000000080204544 <.Lpcrel_hi0>:
    80204544:	00002517          	auipc	a0,0x2
    80204548:	04c50513          	add	a0,a0,76 # 80206590 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E>
    8020454c:	ec2a                	sd	a0,24(sp)
    8020454e:	e02e                	sd	a1,0(sp)
    80204550:	e42a                	sd	a0,8(sp)
    80204552:	6502                	ld	a0,0(sp)
    80204554:	65a2                	ld	a1,8(sp)
    80204556:	6105                	add	sp,sp,32
    80204558:	8082                	ret

000000008020455a <_ZN79_$LT$spin..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hdc80ca8a5661e4c1E>:
    8020455a:	1141                	add	sp,sp,-16
    8020455c:	e406                	sd	ra,8(sp)
    8020455e:	e02a                	sd	a0,0(sp)
    80204560:	00000097          	auipc	ra,0x0
    80204564:	054080e7          	jalr	84(ra) # 802045b4 <_ZN93_$LT$spin..mutex..ticket..TicketMutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hfd3cf4e067ceb6feE>
    80204568:	60a2                	ld	ra,8(sp)
    8020456a:	0141                	add	sp,sp,16
    8020456c:	8082                	ret

000000008020456e <_ZN88_$LT$spin..mutex..ticket..TicketMutexGuard$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17he13474f4365ff0ddE>:
    8020456e:	7179                	add	sp,sp,-48
    80204570:	f406                	sd	ra,40(sp)
    80204572:	e42a                	sd	a0,8(sp)
    80204574:	ec2a                	sd	a0,24(sp)
    80204576:	6108                	ld	a0,0(a0)
    80204578:	0505                	add	a0,a0,1
    8020457a:	e82a                	sd	a0,16(sp)
    8020457c:	cd11                	beqz	a0,80204598 <.Lpcrel_hi3>
    8020457e:	a009                	j	80204580 <_ZN88_$LT$spin..mutex..ticket..TicketMutexGuard$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17he13474f4365ff0ddE+0x12>
    80204580:	65c2                	ld	a1,16(sp)
    80204582:	6522                	ld	a0,8(sp)
    80204584:	f02e                	sd	a1,32(sp)
    80204586:	6508                	ld	a0,8(a0)
    80204588:	4605                	li	a2,1
    8020458a:	00000097          	auipc	ra,0x0
    8020458e:	116080e7          	jalr	278(ra) # 802046a0 <_ZN4core4sync6atomic11AtomicUsize5store17h88ff02487228677dE>
    80204592:	70a2                	ld	ra,40(sp)
    80204594:	6145                	add	sp,sp,48
    80204596:	8082                	ret

0000000080204598 <.Lpcrel_hi3>:
    80204598:	00003517          	auipc	a0,0x3
    8020459c:	62850513          	add	a0,a0,1576 # 80207bc0 <str.0>

00000000802045a0 <.Lpcrel_hi4>:
    802045a0:	00003597          	auipc	a1,0x3
    802045a4:	6a058613          	add	a2,a1,1696 # 80207c40 <.L__unnamed_3>
    802045a8:	45f1                	li	a1,28
    802045aa:	00001097          	auipc	ra,0x1
    802045ae:	fb0080e7          	jalr	-80(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

00000000802045b4 <_ZN93_$LT$spin..mutex..ticket..TicketMutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hfd3cf4e067ceb6feE>:
    802045b4:	1141                	add	sp,sp,-16
    802045b6:	e42a                	sd	a0,8(sp)
    802045b8:	6908                	ld	a0,16(a0)
    802045ba:	0141                	add	sp,sp,16
    802045bc:	8082                	ret

00000000802045be <_ZN22buddy_system_allocator11linked_list10LinkedList4push17hccc36ab515f8c6bdE>:
    802045be:	7179                	add	sp,sp,-48
    802045c0:	e02e                	sd	a1,0(sp)
    802045c2:	e42a                	sd	a0,8(sp)
    802045c4:	f02a                	sd	a0,32(sp)
    802045c6:	f42e                	sd	a1,40(sp)
    802045c8:	6108                	ld	a0,0(a0)
    802045ca:	e82a                	sd	a0,16(sp)
    802045cc:	852e                	mv	a0,a1
    802045ce:	ec2a                	sd	a0,24(sp)
    802045d0:	0075f513          	and	a0,a1,7
    802045d4:	e909                	bnez	a0,802045e6 <_ZN22buddy_system_allocator11linked_list10LinkedList4push17hccc36ab515f8c6bdE+0x28>
    802045d6:	a009                	j	802045d8 <_ZN22buddy_system_allocator11linked_list10LinkedList4push17hccc36ab515f8c6bdE+0x1a>
    802045d8:	6502                	ld	a0,0(sp)
    802045da:	65a2                	ld	a1,8(sp)
    802045dc:	6642                	ld	a2,16(sp)
    802045de:	e110                	sd	a2,0(a0)
    802045e0:	e188                	sd	a0,0(a1)
    802045e2:	6145                	add	sp,sp,48
    802045e4:	8082                	ret
    802045e6:	65e2                	ld	a1,24(sp)

00000000802045e8 <.Lpcrel_hi0>:
    802045e8:	00003517          	auipc	a0,0x3
    802045ec:	6e850613          	add	a2,a0,1768 # 80207cd0 <.L__unnamed_1>
    802045f0:	4521                	li	a0,8
    802045f2:	00001097          	auipc	ra,0x1
    802045f6:	fd4080e7          	jalr	-44(ra) # 802055c6 <_ZN4core9panicking36panic_misaligned_pointer_dereference17h8d2ff04f0586d390E>
	...

00000000802045fc <_ZN4core3cmp3Ord3min17h4e799eda9606b270E>:
    802045fc:	1101                	add	sp,sp,-32
    802045fe:	ec06                	sd	ra,24(sp)
    80204600:	e42a                	sd	a0,8(sp)
    80204602:	e82e                	sd	a1,16(sp)
    80204604:	00000097          	auipc	ra,0x0
    80204608:	024080e7          	jalr	36(ra) # 80204628 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E>
    8020460c:	60e2                	ld	ra,24(sp)
    8020460e:	6105                	add	sp,sp,32
    80204610:	8082                	ret

0000000080204612 <_ZN4core3cmp3min17hb6be1ea6d9a29020E>:
    80204612:	1101                	add	sp,sp,-32
    80204614:	ec06                	sd	ra,24(sp)
    80204616:	e42a                	sd	a0,8(sp)
    80204618:	e82e                	sd	a1,16(sp)
    8020461a:	00000097          	auipc	ra,0x0
    8020461e:	fe2080e7          	jalr	-30(ra) # 802045fc <_ZN4core3cmp3Ord3min17h4e799eda9606b270E>
    80204622:	60e2                	ld	ra,24(sp)
    80204624:	6105                	add	sp,sp,32
    80204626:	8082                	ret

0000000080204628 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E>:
    80204628:	715d                	add	sp,sp,-80
    8020462a:	e486                	sd	ra,72(sp)
    8020462c:	e42a                	sd	a0,8(sp)
    8020462e:	e82e                	sd	a1,16(sp)
    80204630:	4505                	li	a0,1
    80204632:	02a10fa3          	sb	a0,63(sp)
    80204636:	02a10f23          	sb	a0,62(sp)
    8020463a:	0028                	add	a0,sp,8
    8020463c:	f42a                	sd	a0,40(sp)
    8020463e:	0808                	add	a0,sp,16
    80204640:	f82a                	sd	a0,48(sp)
    80204642:	7522                	ld	a0,40(sp)
    80204644:	75c2                	ld	a1,48(sp)
    80204646:	00000097          	auipc	ra,0x0
    8020464a:	4fa080e7          	jalr	1274(ra) # 80204b40 <_ZN4core3ops8function6FnOnce9call_once17hee2436450c22edc8E>
    8020464e:	02a103a3          	sb	a0,39(sp)
    80204652:	02714503          	lbu	a0,39(sp)
    80204656:	2505                	addw	a0,a0,1
    80204658:	0ff57513          	zext.b	a0,a0
    8020465c:	4589                	li	a1,2
    8020465e:	00b56563          	bltu	a0,a1,80204668 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x40>
    80204662:	a009                	j	80204664 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x3c>
    80204664:	a801                	j	80204674 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x4c>
    80204666:	0000                	unimp
    80204668:	4501                	li	a0,0
    8020466a:	02a10fa3          	sb	a0,63(sp)
    8020466e:	6522                	ld	a0,8(sp)
    80204670:	ec2a                	sd	a0,24(sp)
    80204672:	a039                	j	80204680 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x58>
    80204674:	4501                	li	a0,0
    80204676:	02a10f23          	sb	a0,62(sp)
    8020467a:	6542                	ld	a0,16(sp)
    8020467c:	ec2a                	sd	a0,24(sp)
    8020467e:	a009                	j	80204680 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x58>
    80204680:	03e14503          	lbu	a0,62(sp)
    80204684:	8905                	and	a0,a0,1
    80204686:	e519                	bnez	a0,80204694 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x6c>
    80204688:	a009                	j	8020468a <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x62>
    8020468a:	03f14503          	lbu	a0,63(sp)
    8020468e:	8905                	and	a0,a0,1
    80204690:	e519                	bnez	a0,8020469e <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x76>
    80204692:	a011                	j	80204696 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x6e>
    80204694:	bfdd                	j	8020468a <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x62>
    80204696:	6562                	ld	a0,24(sp)
    80204698:	60a6                	ld	ra,72(sp)
    8020469a:	6161                	add	sp,sp,80
    8020469c:	8082                	ret
    8020469e:	bfe5                	j	80204696 <_ZN4core3cmp6min_by17h5ad6ffa8ddfa1ec0E+0x6e>

00000000802046a0 <_ZN4core4sync6atomic11AtomicUsize5store17h88ff02487228677dE>:
    802046a0:	7179                	add	sp,sp,-48
    802046a2:	f406                	sd	ra,40(sp)
    802046a4:	e42a                	sd	a0,8(sp)
    802046a6:	e82e                	sd	a1,16(sp)
    802046a8:	00c10fa3          	sb	a2,31(sp)
    802046ac:	f02a                	sd	a0,32(sp)
    802046ae:	00000097          	auipc	ra,0x0
    802046b2:	57a080e7          	jalr	1402(ra) # 80204c28 <_ZN4core4sync6atomic12atomic_store17h7833e2f3e81bdbd4E>
    802046b6:	70a2                	ld	ra,40(sp)
    802046b8:	6145                	add	sp,sp,48
    802046ba:	8082                	ret

00000000802046bc <_ZN22buddy_system_allocator4Heap11add_to_heap17he537dc19b017333aE>:
    802046bc:	7115                	add	sp,sp,-224
    802046be:	ed86                	sd	ra,216(sp)
    802046c0:	e12a                	sd	a0,128(sp)
    802046c2:	e92e                	sd	a1,144(sp)
    802046c4:	ed32                	sd	a2,152(sp)
    802046c6:	f92a                	sd	a0,176(sp)
    802046c8:	65ca                	ld	a1,144(sp)
    802046ca:	00858513          	add	a0,a1,8
    802046ce:	e52a                	sd	a0,136(sp)
    802046d0:	00b56963          	bltu	a0,a1,802046e2 <.Lpcrel_hi0>
    802046d4:	a009                	j	802046d6 <_ZN22buddy_system_allocator4Heap11add_to_heap17he537dc19b017333aE+0x1a>
    802046d6:	652a                	ld	a0,136(sp)
    802046d8:	fff50593          	add	a1,a0,-1
    802046dc:	fcae                	sd	a1,120(sp)
    802046de:	c50d                	beqz	a0,80204708 <.Lpcrel_hi2>
    802046e0:	a839                	j	802046fe <.Lpcrel_hi1+0x14>

00000000802046e2 <.Lpcrel_hi0>:
    802046e2:	00003517          	auipc	a0,0x3
    802046e6:	74e50513          	add	a0,a0,1870 # 80207e30 <str.0>

00000000802046ea <.Lpcrel_hi1>:
    802046ea:	00003597          	auipc	a1,0x3
    802046ee:	72e58613          	add	a2,a1,1838 # 80207e18 <.L__unnamed_2>
    802046f2:	45f1                	li	a1,28
    802046f4:	00001097          	auipc	ra,0x1
    802046f8:	e66080e7          	jalr	-410(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802046fc:	0000                	unimp
    802046fe:	5561                	li	a0,-8
    80204700:	f8aa                	sd	a0,112(sp)
    80204702:	4501                	li	a0,0
    80204704:	ed05                	bnez	a0,8020473c <.Lpcrel_hi4>
    80204706:	a005                	j	80204726 <.Lpcrel_hi3+0x16>

0000000080204708 <.Lpcrel_hi2>:
    80204708:	00003517          	auipc	a0,0x3
    8020470c:	76850513          	add	a0,a0,1896 # 80207e70 <str.1>

0000000080204710 <.Lpcrel_hi3>:
    80204710:	00003597          	auipc	a1,0x3
    80204714:	74058613          	add	a2,a1,1856 # 80207e50 <.L__unnamed_3>
    80204718:	02100593          	li	a1,33
    8020471c:	00001097          	auipc	ra,0x1
    80204720:	e3e080e7          	jalr	-450(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204724:	0000                	unimp
    80204726:	7566                	ld	a0,120(sp)
    80204728:	75c6                	ld	a1,112(sp)
    8020472a:	8d6d                	and	a0,a0,a1
    8020472c:	e92a                	sd	a0,144(sp)
    8020472e:	656a                	ld	a0,152(sp)
    80204730:	f0aa                	sd	a0,96(sp)
    80204732:	5561                	li	a0,-8
    80204734:	f4aa                	sd	a0,104(sp)
    80204736:	4501                	li	a0,0
    80204738:	e90d                	bnez	a0,8020476a <.Lpcrel_hi6>
    8020473a:	a839                	j	80204758 <.Lpcrel_hi5+0x14>

000000008020473c <.Lpcrel_hi4>:
    8020473c:	00003517          	auipc	a0,0x3
    80204740:	6f450513          	add	a0,a0,1780 # 80207e30 <str.0>

0000000080204744 <.Lpcrel_hi5>:
    80204744:	00003597          	auipc	a1,0x3
    80204748:	75458613          	add	a2,a1,1876 # 80207e98 <.L__unnamed_4>
    8020474c:	45f1                	li	a1,28
    8020474e:	00001097          	auipc	ra,0x1
    80204752:	e0c080e7          	jalr	-500(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204756:	0000                	unimp
    80204758:	7506                	ld	a0,96(sp)
    8020475a:	75a6                	ld	a1,104(sp)
    8020475c:	8d6d                	and	a0,a0,a1
    8020475e:	ed2a                	sd	a0,152(sp)
    80204760:	65ca                	ld	a1,144(sp)
    80204762:	656a                	ld	a0,152(sp)
    80204764:	02b56663          	bltu	a0,a1,80204790 <.Lpcrel_hi8>
    80204768:	a839                	j	80204786 <.Lpcrel_hi7+0x14>

000000008020476a <.Lpcrel_hi6>:
    8020476a:	00003517          	auipc	a0,0x3
    8020476e:	6c650513          	add	a0,a0,1734 # 80207e30 <str.0>

0000000080204772 <.Lpcrel_hi7>:
    80204772:	00003597          	auipc	a1,0x3
    80204776:	73e58613          	add	a2,a1,1854 # 80207eb0 <.L__unnamed_5>
    8020477a:	45f1                	li	a1,28
    8020477c:	00001097          	auipc	ra,0x1
    80204780:	dde080e7          	jalr	-546(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204784:	0000                	unimp
    80204786:	4501                	li	a0,0
    80204788:	f12a                	sd	a0,160(sp)
    8020478a:	654a                	ld	a0,144(sp)
    8020478c:	f52a                	sd	a0,168(sp)
    8020478e:	a839                	j	802047ac <.Lpcrel_hi9+0x14>

0000000080204790 <.Lpcrel_hi8>:
    80204790:	00003517          	auipc	a0,0x3
    80204794:	73850513          	add	a0,a0,1848 # 80207ec8 <.L__unnamed_6>

0000000080204798 <.Lpcrel_hi9>:
    80204798:	00003597          	auipc	a1,0x3
    8020479c:	75058613          	add	a2,a1,1872 # 80207ee8 <.L__unnamed_7>
    802047a0:	45f9                	li	a1,30
    802047a2:	00001097          	auipc	ra,0x1
    802047a6:	db8080e7          	jalr	-584(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802047aa:	0000                	unimp
    802047ac:	75aa                	ld	a1,168(sp)
    802047ae:	00858513          	add	a0,a1,8
    802047b2:	ecaa                	sd	a0,88(sp)
    802047b4:	00b56863          	bltu	a0,a1,802047c4 <.Lpcrel_hi10>
    802047b8:	a009                	j	802047ba <.Lpcrel_hi9+0x22>
    802047ba:	65e6                	ld	a1,88(sp)
    802047bc:	656a                	ld	a0,152(sp)
    802047be:	02b57a63          	bgeu	a0,a1,802047f2 <.Lpcrel_hi11+0x26>
    802047c2:	a839                	j	802047e0 <.Lpcrel_hi11+0x14>

00000000802047c4 <.Lpcrel_hi10>:
    802047c4:	00003517          	auipc	a0,0x3
    802047c8:	66c50513          	add	a0,a0,1644 # 80207e30 <str.0>

00000000802047cc <.Lpcrel_hi11>:
    802047cc:	00003597          	auipc	a1,0x3
    802047d0:	73458613          	add	a2,a1,1844 # 80207f00 <.L__unnamed_8>
    802047d4:	45f1                	li	a1,28
    802047d6:	00001097          	auipc	ra,0x1
    802047da:	d84080e7          	jalr	-636(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802047de:	0000                	unimp
    802047e0:	658a                	ld	a1,128(sp)
    802047e2:	750a                	ld	a0,160(sp)
    802047e4:	1105b583          	ld	a1,272(a1)
    802047e8:	952e                	add	a0,a0,a1
    802047ea:	e8aa                	sd	a0,80(sp)
    802047ec:	16b56463          	bltu	a0,a1,80204954 <.Lpcrel_hi23>
    802047f0:	aa99                	j	80204946 <.Lpcrel_hi22+0x14>
    802047f2:	75aa                	ld	a1,168(sp)
    802047f4:	e0ae                	sd	a1,64(sp)
    802047f6:	4501                	li	a0,0
    802047f8:	40b505b3          	sub	a1,a0,a1
    802047fc:	e4ae                	sd	a1,72(sp)
    802047fe:	02b57063          	bgeu	a0,a1,8020481e <.Lpcrel_hi12>
    80204802:	a009                	j	80204804 <.Lpcrel_hi11+0x38>
    80204804:	6506                	ld	a0,64(sp)
    80204806:	65a6                	ld	a1,72(sp)
    80204808:	8d6d                	and	a0,a0,a1
    8020480a:	f82a                	sd	a0,48(sp)
    8020480c:	fd2a                	sd	a0,184(sp)
    8020480e:	656a                	ld	a0,152(sp)
    80204810:	75aa                	ld	a1,168(sp)
    80204812:	40b50633          	sub	a2,a0,a1
    80204816:	fc32                	sd	a2,56(sp)
    80204818:	04b56563          	bltu	a0,a1,80204862 <.Lpcrel_hi14>
    8020481c:	a839                	j	8020483a <.Lpcrel_hi13+0x14>

000000008020481e <.Lpcrel_hi12>:
    8020481e:	00003517          	auipc	a0,0x3
    80204822:	61250513          	add	a0,a0,1554 # 80207e30 <str.0>

0000000080204826 <.Lpcrel_hi13>:
    80204826:	00003597          	auipc	a1,0x3
    8020482a:	6f258613          	add	a2,a1,1778 # 80207f18 <.L__unnamed_9>
    8020482e:	45f1                	li	a1,28
    80204830:	00001097          	auipc	ra,0x1
    80204834:	d2a080e7          	jalr	-726(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204838:	0000                	unimp
    8020483a:	7562                	ld	a0,56(sp)
    8020483c:	00000097          	auipc	ra,0x0
    80204840:	186080e7          	jalr	390(ra) # 802049c2 <_ZN22buddy_system_allocator17prev_power_of_two17h907a66931bf16457E>
    80204844:	85aa                	mv	a1,a0
    80204846:	7542                	ld	a0,48(sp)
    80204848:	00000097          	auipc	ra,0x0
    8020484c:	dca080e7          	jalr	-566(ra) # 80204612 <_ZN4core3cmp3min17hb6be1ea6d9a29020E>
    80204850:	85aa                	mv	a1,a0
    80204852:	f02e                	sd	a1,32(sp)
    80204854:	e1aa                	sd	a0,192(sp)
    80204856:	758a                	ld	a1,160(sp)
    80204858:	952e                	add	a0,a0,a1
    8020485a:	f42a                	sd	a0,40(sp)
    8020485c:	06b56a63          	bltu	a0,a1,802048d0 <.Lpcrel_hi18>
    80204860:	a005                	j	80204880 <.Lpcrel_hi15+0x16>

0000000080204862 <.Lpcrel_hi14>:
    80204862:	00003517          	auipc	a0,0x3
    80204866:	60e50513          	add	a0,a0,1550 # 80207e70 <str.1>

000000008020486a <.Lpcrel_hi15>:
    8020486a:	00003597          	auipc	a1,0x3
    8020486e:	6c658613          	add	a2,a1,1734 # 80207f30 <.L__unnamed_10>
    80204872:	02100593          	li	a1,33
    80204876:	00001097          	auipc	ra,0x1
    8020487a:	ce4080e7          	jalr	-796(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    8020487e:	0000                	unimp
    80204880:	7502                	ld	a0,32(sp)
    80204882:	75a2                	ld	a1,40(sp)
    80204884:	f12e                	sd	a1,160(sp)
    80204886:	e5aa                	sd	a0,200(sp)
    80204888:	4581                	li	a1,0
    8020488a:	8d89                	sub	a1,a1,a0
    8020488c:	8de9                	and	a1,a1,a0

000000008020488e <.Lpcrel_hi16>:
    8020488e:	00005617          	auipc	a2,0x5
    80204892:	77260613          	add	a2,a2,1906 # 8020a000 <erodata>
    80204896:	6210                	ld	a2,0(a2)
    80204898:	02c585b3          	mul	a1,a1,a2
    8020489c:	03a5d613          	srl	a2,a1,0x3a

00000000802048a0 <.Lpcrel_hi17>:
    802048a0:	00003597          	auipc	a1,0x3
    802048a4:	44858593          	add	a1,a1,1096 # 80207ce8 <.LCPI2_1>
    802048a8:	95b2                	add	a1,a1,a2
    802048aa:	0005c583          	lbu	a1,0(a1)
    802048ae:	04000613          	li	a2,64
    802048b2:	e832                	sd	a2,16(sp)
    802048b4:	ec2e                	sd	a1,24(sp)
    802048b6:	e119                	bnez	a0,802048bc <.Lpcrel_hi17+0x1c>
    802048b8:	6542                	ld	a0,16(sp)
    802048ba:	ec2a                	sd	a0,24(sp)
    802048bc:	6562                	ld	a0,24(sp)
    802048be:	e9aa                	sd	a0,208(sp)
    802048c0:	0d016503          	lwu	a0,208(sp)
    802048c4:	e42a                	sd	a0,8(sp)
    802048c6:	02000593          	li	a1,32
    802048ca:	02b56163          	bltu	a0,a1,802048ec <.Lpcrel_hi19+0x14>
    802048ce:	a83d                	j	8020490c <.Lpcrel_hi19+0x34>

00000000802048d0 <.Lpcrel_hi18>:
    802048d0:	00003517          	auipc	a0,0x3
    802048d4:	56050513          	add	a0,a0,1376 # 80207e30 <str.0>

00000000802048d8 <.Lpcrel_hi19>:
    802048d8:	00003597          	auipc	a1,0x3
    802048dc:	67058613          	add	a2,a1,1648 # 80207f48 <.L__unnamed_11>
    802048e0:	45f1                	li	a1,28
    802048e2:	00001097          	auipc	ra,0x1
    802048e6:	c78080e7          	jalr	-904(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    802048ea:	0000                	unimp
    802048ec:	650a                	ld	a0,128(sp)
    802048ee:	65a2                	ld	a1,8(sp)
    802048f0:	058e                	sll	a1,a1,0x3
    802048f2:	952e                	add	a0,a0,a1
    802048f4:	75aa                	ld	a1,168(sp)
    802048f6:	00000097          	auipc	ra,0x0
    802048fa:	cc8080e7          	jalr	-824(ra) # 802045be <_ZN22buddy_system_allocator11linked_list10LinkedList4push17hccc36ab515f8c6bdE>
    802048fe:	7502                	ld	a0,32(sp)
    80204900:	75aa                	ld	a1,168(sp)
    80204902:	952e                	add	a0,a0,a1
    80204904:	e02a                	sd	a0,0(sp)
    80204906:	02b56263          	bltu	a0,a1,8020492a <.Lpcrel_hi21>
    8020490a:	a829                	j	80204924 <.Lpcrel_hi20+0x16>
    8020490c:	6522                	ld	a0,8(sp)

000000008020490e <.Lpcrel_hi20>:
    8020490e:	00003597          	auipc	a1,0x3
    80204912:	65258613          	add	a2,a1,1618 # 80207f60 <.L__unnamed_12>
    80204916:	02000593          	li	a1,32
    8020491a:	00001097          	auipc	ra,0x1
    8020491e:	c6c080e7          	jalr	-916(ra) # 80205586 <_ZN4core9panicking18panic_bounds_check17h05a1b05d1577c619E>
    80204922:	0000                	unimp
    80204924:	6502                	ld	a0,0(sp)
    80204926:	f52a                	sd	a0,168(sp)
    80204928:	b551                	j	802047ac <.Lpcrel_hi9+0x14>

000000008020492a <.Lpcrel_hi21>:
    8020492a:	00003517          	auipc	a0,0x3
    8020492e:	50650513          	add	a0,a0,1286 # 80207e30 <str.0>

0000000080204932 <.Lpcrel_hi22>:
    80204932:	00003597          	auipc	a1,0x3
    80204936:	64658613          	add	a2,a1,1606 # 80207f78 <.L__unnamed_13>
    8020493a:	45f1                	li	a1,28
    8020493c:	00001097          	auipc	ra,0x1
    80204940:	c1e080e7          	jalr	-994(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204944:	0000                	unimp
    80204946:	6546                	ld	a0,80(sp)
    80204948:	658a                	ld	a1,128(sp)
    8020494a:	10a5b823          	sd	a0,272(a1)
    8020494e:	60ee                	ld	ra,216(sp)
    80204950:	612d                	add	sp,sp,224
    80204952:	8082                	ret

0000000080204954 <.Lpcrel_hi23>:
    80204954:	00003517          	auipc	a0,0x3
    80204958:	4dc50513          	add	a0,a0,1244 # 80207e30 <str.0>

000000008020495c <.Lpcrel_hi24>:
    8020495c:	00003597          	auipc	a1,0x3
    80204960:	63458613          	add	a2,a1,1588 # 80207f90 <.L__unnamed_14>
    80204964:	45f1                	li	a1,28
    80204966:	00001097          	auipc	ra,0x1
    8020496a:	bf4080e7          	jalr	-1036(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080204970 <_ZN22buddy_system_allocator4Heap4init17h9eb587a9e0e7981eE>:
    80204970:	7139                	add	sp,sp,-64
    80204972:	fc06                	sd	ra,56(sp)
    80204974:	e42e                	sd	a1,8(sp)
    80204976:	e82a                	sd	a0,16(sp)
    80204978:	f02a                	sd	a0,32(sp)
    8020497a:	f42e                	sd	a1,40(sp)
    8020497c:	f832                	sd	a2,48(sp)
    8020497e:	00c58533          	add	a0,a1,a2
    80204982:	ec2a                	sd	a0,24(sp)
    80204984:	00b56d63          	bltu	a0,a1,8020499e <.Lpcrel_hi25>
    80204988:	a009                	j	8020498a <_ZN22buddy_system_allocator4Heap4init17h9eb587a9e0e7981eE+0x1a>
    8020498a:	6662                	ld	a2,24(sp)
    8020498c:	65a2                	ld	a1,8(sp)
    8020498e:	6542                	ld	a0,16(sp)
    80204990:	00000097          	auipc	ra,0x0
    80204994:	d2c080e7          	jalr	-724(ra) # 802046bc <_ZN22buddy_system_allocator4Heap11add_to_heap17he537dc19b017333aE>
    80204998:	70e2                	ld	ra,56(sp)
    8020499a:	6121                	add	sp,sp,64
    8020499c:	8082                	ret

000000008020499e <.Lpcrel_hi25>:
    8020499e:	00003517          	auipc	a0,0x3
    802049a2:	49250513          	add	a0,a0,1170 # 80207e30 <str.0>

00000000802049a6 <.Lpcrel_hi26>:
    802049a6:	00003597          	auipc	a1,0x3
    802049aa:	60258613          	add	a2,a1,1538 # 80207fa8 <.L__unnamed_15>
    802049ae:	45f1                	li	a1,28
    802049b0:	00001097          	auipc	ra,0x1
    802049b4:	baa080e7          	jalr	-1110(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

00000000802049ba <_ZN78_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..ops..deref..Deref$GT$5deref17h7df0c075793b5bd0E>:
    802049ba:	1141                	add	sp,sp,-16
    802049bc:	e42a                	sd	a0,8(sp)
    802049be:	0141                	add	sp,sp,16
    802049c0:	8082                	ret

00000000802049c2 <_ZN22buddy_system_allocator17prev_power_of_two17h907a66931bf16457E>:
    802049c2:	7139                	add	sp,sp,-64
    802049c4:	ec2a                	sd	a0,24(sp)
    802049c6:	f42a                	sd	a0,40(sp)
    802049c8:	04000513          	li	a0,64
    802049cc:	f02a                	sd	a0,32(sp)
    802049ce:	4501                	li	a0,0
    802049d0:	e559                	bnez	a0,80204a5e <.Lpcrel_hi77>
    802049d2:	a009                	j	802049d4 <_ZN22buddy_system_allocator17prev_power_of_two17h907a66931bf16457E+0x12>
    802049d4:	7502                	ld	a0,32(sp)
    802049d6:	65e2                	ld	a1,24(sp)
    802049d8:	f82e                	sd	a1,48(sp)
    802049da:	0015d613          	srl	a2,a1,0x1
    802049de:	8dd1                	or	a1,a1,a2
    802049e0:	0025d613          	srl	a2,a1,0x2
    802049e4:	8dd1                	or	a1,a1,a2
    802049e6:	0045d613          	srl	a2,a1,0x4
    802049ea:	8dd1                	or	a1,a1,a2
    802049ec:	0085d613          	srl	a2,a1,0x8
    802049f0:	8dd1                	or	a1,a1,a2
    802049f2:	0105d613          	srl	a2,a1,0x10
    802049f6:	8dd1                	or	a1,a1,a2
    802049f8:	0205d613          	srl	a2,a1,0x20
    802049fc:	8dd1                	or	a1,a1,a2
    802049fe:	fff5c593          	not	a1,a1
    80204a02:	0015d613          	srl	a2,a1,0x1

0000000080204a06 <.Lpcrel_hi73>:
    80204a06:	00005697          	auipc	a3,0x5
    80204a0a:	61268693          	add	a3,a3,1554 # 8020a018 <.LCPI21_0>
    80204a0e:	6294                	ld	a3,0(a3)
    80204a10:	8e75                	and	a2,a2,a3
    80204a12:	40c58633          	sub	a2,a1,a2

0000000080204a16 <.Lpcrel_hi74>:
    80204a16:	00005597          	auipc	a1,0x5
    80204a1a:	60a58593          	add	a1,a1,1546 # 8020a020 <.LCPI21_1>
    80204a1e:	6194                	ld	a3,0(a1)
    80204a20:	00d675b3          	and	a1,a2,a3
    80204a24:	8209                	srl	a2,a2,0x2
    80204a26:	8e75                	and	a2,a2,a3
    80204a28:	95b2                	add	a1,a1,a2
    80204a2a:	0045d613          	srl	a2,a1,0x4
    80204a2e:	95b2                	add	a1,a1,a2

0000000080204a30 <.Lpcrel_hi75>:
    80204a30:	00005617          	auipc	a2,0x5
    80204a34:	5f860613          	add	a2,a2,1528 # 8020a028 <.LCPI21_2>
    80204a38:	6210                	ld	a2,0(a2)
    80204a3a:	8df1                	and	a1,a1,a2

0000000080204a3c <.Lpcrel_hi76>:
    80204a3c:	00005617          	auipc	a2,0x5
    80204a40:	5f460613          	add	a2,a2,1524 # 8020a030 <.LCPI21_3>
    80204a44:	6210                	ld	a2,0(a2)
    80204a46:	02c585b3          	mul	a1,a1,a2
    80204a4a:	91e1                	srl	a1,a1,0x38
    80204a4c:	fc2e                	sd	a1,56(sp)
    80204a4e:	03816583          	lwu	a1,56(sp)
    80204a52:	40b50633          	sub	a2,a0,a1
    80204a56:	e832                	sd	a2,16(sp)
    80204a58:	02b56863          	bltu	a0,a1,80204a88 <.Lpcrel_hi79>
    80204a5c:	a005                	j	80204a7c <.Lpcrel_hi78+0x16>

0000000080204a5e <.Lpcrel_hi77>:
    80204a5e:	00003517          	auipc	a0,0x3
    80204a62:	5a250513          	add	a0,a0,1442 # 80208000 <str.3>

0000000080204a66 <.Lpcrel_hi78>:
    80204a66:	00003597          	auipc	a1,0x3
    80204a6a:	58258613          	add	a2,a1,1410 # 80207fe8 <.L__unnamed_44>
    80204a6e:	02100593          	li	a1,33
    80204a72:	00001097          	auipc	ra,0x1
    80204a76:	ae8080e7          	jalr	-1304(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204a7a:	0000                	unimp
    80204a7c:	6542                	ld	a0,16(sp)
    80204a7e:	fff50593          	add	a1,a0,-1
    80204a82:	e42e                	sd	a1,8(sp)
    80204a84:	c51d                	beqz	a0,80204ab2 <.Lpcrel_hi81>
    80204a86:	a005                	j	80204aa6 <.Lpcrel_hi80+0x16>

0000000080204a88 <.Lpcrel_hi79>:
    80204a88:	00003517          	auipc	a0,0x3
    80204a8c:	3e850513          	add	a0,a0,1000 # 80207e70 <str.1>

0000000080204a90 <.Lpcrel_hi80>:
    80204a90:	00003597          	auipc	a1,0x3
    80204a94:	55858613          	add	a2,a1,1368 # 80207fe8 <.L__unnamed_44>
    80204a98:	02100593          	li	a1,33
    80204a9c:	00001097          	auipc	ra,0x1
    80204aa0:	abe080e7          	jalr	-1346(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204aa4:	0000                	unimp
    80204aa6:	6522                	ld	a0,8(sp)
    80204aa8:	04000593          	li	a1,64
    80204aac:	02b56263          	bltu	a0,a1,80204ad0 <.Lpcrel_hi82+0x16>
    80204ab0:	a035                	j	80204adc <.Lpcrel_hi83>

0000000080204ab2 <.Lpcrel_hi81>:
    80204ab2:	00003517          	auipc	a0,0x3
    80204ab6:	3be50513          	add	a0,a0,958 # 80207e70 <str.1>

0000000080204aba <.Lpcrel_hi82>:
    80204aba:	00003597          	auipc	a1,0x3
    80204abe:	56e58613          	add	a2,a1,1390 # 80208028 <.L__unnamed_45>
    80204ac2:	02100593          	li	a1,33
    80204ac6:	00001097          	auipc	ra,0x1
    80204aca:	a94080e7          	jalr	-1388(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80204ace:	0000                	unimp
    80204ad0:	65a2                	ld	a1,8(sp)
    80204ad2:	4505                	li	a0,1
    80204ad4:	00b51533          	sll	a0,a0,a1
    80204ad8:	6121                	add	sp,sp,64
    80204ada:	8082                	ret

0000000080204adc <.Lpcrel_hi83>:
    80204adc:	00003517          	auipc	a0,0x3
    80204ae0:	4e450513          	add	a0,a0,1252 # 80207fc0 <str.2>

0000000080204ae4 <.Lpcrel_hi84>:
    80204ae4:	00003597          	auipc	a1,0x3
    80204ae8:	55c58613          	add	a2,a1,1372 # 80208040 <.L__unnamed_46>
    80204aec:	02300593          	li	a1,35
    80204af0:	00001097          	auipc	ra,0x1
    80204af4:	a6a080e7          	jalr	-1430(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080204afa <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E>:
    80204afa:	7179                	add	sp,sp,-48
    80204afc:	e42e                	sd	a1,8(sp)
    80204afe:	e82a                	sd	a0,16(sp)
    80204b00:	f02a                	sd	a0,32(sp)
    80204b02:	f42e                	sd	a1,40(sp)
    80204b04:	6108                	ld	a0,0(a0)
    80204b06:	618c                	ld	a1,0(a1)
    80204b08:	00b56a63          	bltu	a0,a1,80204b1c <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x22>
    80204b0c:	a009                	j	80204b0e <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x14>
    80204b0e:	65a2                	ld	a1,8(sp)
    80204b10:	6542                	ld	a0,16(sp)
    80204b12:	6108                	ld	a0,0(a0)
    80204b14:	618c                	ld	a1,0(a1)
    80204b16:	02b50063          	beq	a0,a1,80204b36 <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x3c>
    80204b1a:	a811                	j	80204b2e <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x34>
    80204b1c:	0ff00513          	li	a0,255
    80204b20:	00a10fa3          	sb	a0,31(sp)
    80204b24:	a009                	j	80204b26 <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x2c>
    80204b26:	01f10503          	lb	a0,31(sp)
    80204b2a:	6145                	add	sp,sp,48
    80204b2c:	8082                	ret
    80204b2e:	4505                	li	a0,1
    80204b30:	00a10fa3          	sb	a0,31(sp)
    80204b34:	a029                	j	80204b3e <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x44>
    80204b36:	4501                	li	a0,0
    80204b38:	00a10fa3          	sb	a0,31(sp)
    80204b3c:	a009                	j	80204b3e <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x44>
    80204b3e:	b7e5                	j	80204b26 <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E+0x2c>

0000000080204b40 <_ZN4core3ops8function6FnOnce9call_once17hee2436450c22edc8E>:
    80204b40:	1101                	add	sp,sp,-32
    80204b42:	ec06                	sd	ra,24(sp)
    80204b44:	e02a                	sd	a0,0(sp)
    80204b46:	e42e                	sd	a1,8(sp)
    80204b48:	6502                	ld	a0,0(sp)
    80204b4a:	65a2                	ld	a1,8(sp)
    80204b4c:	00000097          	auipc	ra,0x0
    80204b50:	fae080e7          	jalr	-82(ra) # 80204afa <_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h1cabba7a8afaad31E>
    80204b54:	60e2                	ld	ra,24(sp)
    80204b56:	6105                	add	sp,sp,32
    80204b58:	8082                	ret

0000000080204b5a <_ZN4core3ptr80drop_in_place$LT$spin..mutex..MutexGuard$LT$buddy_system_allocator..Heap$GT$$GT$17hfaa414ee47c0699cE>:
    80204b5a:	1141                	add	sp,sp,-16
    80204b5c:	e406                	sd	ra,8(sp)
    80204b5e:	e02a                	sd	a0,0(sp)
    80204b60:	00000097          	auipc	ra,0x0
    80204b64:	00e080e7          	jalr	14(ra) # 80204b6e <_ZN4core3ptr94drop_in_place$LT$spin..mutex..ticket..TicketMutexGuard$LT$buddy_system_allocator..Heap$GT$$GT$17h349a5f9c2fbbb10bE>
    80204b68:	60a2                	ld	ra,8(sp)
    80204b6a:	0141                	add	sp,sp,16
    80204b6c:	8082                	ret

0000000080204b6e <_ZN4core3ptr94drop_in_place$LT$spin..mutex..ticket..TicketMutexGuard$LT$buddy_system_allocator..Heap$GT$$GT$17h349a5f9c2fbbb10bE>:
    80204b6e:	1141                	add	sp,sp,-16
    80204b70:	e406                	sd	ra,8(sp)
    80204b72:	e02a                	sd	a0,0(sp)
    80204b74:	00000097          	auipc	ra,0x0
    80204b78:	9fa080e7          	jalr	-1542(ra) # 8020456e <_ZN88_$LT$spin..mutex..ticket..TicketMutexGuard$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17he13474f4365ff0ddE>
    80204b7c:	60a2                	ld	ra,8(sp)
    80204b7e:	0141                	add	sp,sp,16
    80204b80:	8082                	ret

0000000080204b82 <_ZN4core4sync6atomic11atomic_load17hfe406beff556b5f5E>:
    80204b82:	7135                	add	sp,sp,-160
    80204b84:	ed06                	sd	ra,152(sp)
    80204b86:	e82a                	sd	a0,16(sp)
    80204b88:	02b103a3          	sb	a1,39(sp)
    80204b8c:	e92a                	sd	a0,144(sp)
    80204b8e:	02714503          	lbu	a0,39(sp)
    80204b92:	ec2a                	sd	a0,24(sp)
    80204b94:	6562                	ld	a0,24(sp)
    80204b96:	050e                	sll	a0,a0,0x3

0000000080204b98 <.Lpcrel_hi1>:
    80204b98:	00003597          	auipc	a1,0x3
    80204b9c:	4c058593          	add	a1,a1,1216 # 80208058 <.LJTI4_0>
    80204ba0:	952e                	add	a0,a0,a1
    80204ba2:	6108                	ld	a0,0(a0)
    80204ba4:	8502                	jr	a0
	...

0000000080204ba8 <.LBB4_3>:
    80204ba8:	6542                	ld	a0,16(sp)
    80204baa:	6108                	ld	a0,0(a0)
    80204bac:	f42a                	sd	a0,40(sp)
    80204bae:	a88d                	j	80204c20 <.LBB4_7+0x10>

0000000080204bb0 <.LBB4_4>:
    80204bb0:	00003517          	auipc	a0,0x3
    80204bb4:	5d050593          	add	a1,a0,1488 # 80208180 <.L__unnamed_1>
    80204bb8:	1808                	add	a0,sp,48
    80204bba:	e42a                	sd	a0,8(sp)
    80204bbc:	4605                	li	a2,1
    80204bbe:	00000097          	auipc	ra,0x0
    80204bc2:	10e080e7          	jalr	270(ra) # 80204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>
    80204bc6:	6522                	ld	a0,8(sp)

0000000080204bc8 <.Lpcrel_hi3>:
    80204bc8:	00003597          	auipc	a1,0x3
    80204bcc:	5c858593          	add	a1,a1,1480 # 80208190 <.L__unnamed_2>
    80204bd0:	00001097          	auipc	ra,0x1
    80204bd4:	95c080e7          	jalr	-1700(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204bda <.LBB4_5>:
    80204bda:	6542                	ld	a0,16(sp)
    80204bdc:	6108                	ld	a0,0(a0)
    80204bde:	0230000f          	fence	r,rw
    80204be2:	f42a                	sd	a0,40(sp)
    80204be4:	a835                	j	80204c20 <.LBB4_7+0x10>

0000000080204be6 <.LBB4_6>:
    80204be6:	00003517          	auipc	a0,0x3
    80204bea:	4fa50593          	add	a1,a0,1274 # 802080e0 <.L__unnamed_3>
    80204bee:	1088                	add	a0,sp,96
    80204bf0:	e02a                	sd	a0,0(sp)
    80204bf2:	4605                	li	a2,1
    80204bf4:	00000097          	auipc	ra,0x0
    80204bf8:	0d8080e7          	jalr	216(ra) # 80204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>
    80204bfc:	6502                	ld	a0,0(sp)

0000000080204bfe <.Lpcrel_hi5>:
    80204bfe:	00003597          	auipc	a1,0x3
    80204c02:	54258593          	add	a1,a1,1346 # 80208140 <.L__unnamed_4>
    80204c06:	00001097          	auipc	ra,0x1
    80204c0a:	926080e7          	jalr	-1754(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204c10 <.LBB4_7>:
    80204c10:	6542                	ld	a0,16(sp)
    80204c12:	0330000f          	fence	rw,rw
    80204c16:	6108                	ld	a0,0(a0)
    80204c18:	0230000f          	fence	r,rw
    80204c1c:	f42a                	sd	a0,40(sp)
    80204c1e:	a009                	j	80204c20 <.LBB4_7+0x10>
    80204c20:	7522                	ld	a0,40(sp)
    80204c22:	60ea                	ld	ra,152(sp)
    80204c24:	610d                	add	sp,sp,160
    80204c26:	8082                	ret

0000000080204c28 <_ZN4core4sync6atomic12atomic_store17h7833e2f3e81bdbd4E>:
    80204c28:	7171                	add	sp,sp,-176
    80204c2a:	f506                	sd	ra,168(sp)
    80204c2c:	ec2e                	sd	a1,24(sp)
    80204c2e:	f02a                	sd	a0,32(sp)
    80204c30:	02c10ba3          	sb	a2,55(sp)
    80204c34:	ed2a                	sd	a0,152(sp)
    80204c36:	f12e                	sd	a1,160(sp)
    80204c38:	03714503          	lbu	a0,55(sp)
    80204c3c:	f42a                	sd	a0,40(sp)
    80204c3e:	7522                	ld	a0,40(sp)
    80204c40:	050e                	sll	a0,a0,0x3

0000000080204c42 <.Lpcrel_hi6>:
    80204c42:	00003597          	auipc	a1,0x3
    80204c46:	43e58593          	add	a1,a1,1086 # 80208080 <.LJTI5_0>
    80204c4a:	952e                	add	a0,a0,a1
    80204c4c:	6108                	ld	a0,0(a0)
    80204c4e:	8502                	jr	a0
	...

0000000080204c52 <.LBB5_3>:
    80204c52:	6562                	ld	a0,24(sp)
    80204c54:	7582                	ld	a1,32(sp)
    80204c56:	e188                	sd	a0,0(a1)
    80204c58:	a0bd                	j	80204cc6 <.LBB5_7+0xc>

0000000080204c5a <.LBB5_4>:
    80204c5a:	6562                	ld	a0,24(sp)
    80204c5c:	7582                	ld	a1,32(sp)
    80204c5e:	0310000f          	fence	rw,w
    80204c62:	e188                	sd	a0,0(a1)
    80204c64:	a08d                	j	80204cc6 <.LBB5_7+0xc>

0000000080204c66 <.LBB5_5>:
    80204c66:	00003517          	auipc	a0,0x3
    80204c6a:	5d250593          	add	a1,a0,1490 # 80208238 <.L__unnamed_5>
    80204c6e:	1828                	add	a0,sp,56
    80204c70:	e82a                	sd	a0,16(sp)
    80204c72:	4605                	li	a2,1
    80204c74:	00000097          	auipc	ra,0x0
    80204c78:	058080e7          	jalr	88(ra) # 80204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>
    80204c7c:	6542                	ld	a0,16(sp)

0000000080204c7e <.Lpcrel_hi8>:
    80204c7e:	00003597          	auipc	a1,0x3
    80204c82:	5ca58593          	add	a1,a1,1482 # 80208248 <.L__unnamed_6>
    80204c86:	00001097          	auipc	ra,0x1
    80204c8a:	8a6080e7          	jalr	-1882(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204c90 <.LBB5_6>:
    80204c90:	00003517          	auipc	a0,0x3
    80204c94:	55050593          	add	a1,a0,1360 # 802081e0 <.L__unnamed_7>
    80204c98:	10a8                	add	a0,sp,104
    80204c9a:	e42a                	sd	a0,8(sp)
    80204c9c:	4605                	li	a2,1
    80204c9e:	00000097          	auipc	ra,0x0
    80204ca2:	02e080e7          	jalr	46(ra) # 80204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>
    80204ca6:	6522                	ld	a0,8(sp)

0000000080204ca8 <.Lpcrel_hi10>:
    80204ca8:	00003597          	auipc	a1,0x3
    80204cac:	54858593          	add	a1,a1,1352 # 802081f0 <.L__unnamed_8>
    80204cb0:	00001097          	auipc	ra,0x1
    80204cb4:	87c080e7          	jalr	-1924(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204cba <.LBB5_7>:
    80204cba:	6562                	ld	a0,24(sp)
    80204cbc:	7582                	ld	a1,32(sp)
    80204cbe:	0310000f          	fence	rw,w
    80204cc2:	e188                	sd	a0,0(a1)
    80204cc4:	a009                	j	80204cc6 <.LBB5_7+0xc>
    80204cc6:	70aa                	ld	ra,168(sp)
    80204cc8:	614d                	add	sp,sp,176
    80204cca:	8082                	ret

0000000080204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>:
    80204ccc:	7119                	add	sp,sp,-128
    80204cce:	fc86                	sd	ra,120(sp)
    80204cd0:	e832                	sd	a2,16(sp)
    80204cd2:	ec2e                	sd	a1,24(sp)
    80204cd4:	f02a                	sd	a0,32(sp)
    80204cd6:	f4ae                	sd	a1,104(sp)
    80204cd8:	f8b2                	sd	a2,112(sp)
    80204cda:	4505                	li	a0,1
    80204cdc:	02c56763          	bltu	a0,a2,80204d0a <.Lpcrel_hi1>
    80204ce0:	a009                	j	80204ce2 <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E+0x16>
    80204ce2:	7582                	ld	a1,32(sp)
    80204ce4:	6642                	ld	a2,16(sp)
    80204ce6:	66e2                	ld	a3,24(sp)
    80204ce8:	4501                	li	a0,0
    80204cea:	ecaa                	sd	a0,88(sp)
    80204cec:	e994                	sd	a3,16(a1)
    80204cee:	ed90                	sd	a2,24(a1)
    80204cf0:	66e6                	ld	a3,88(sp)
    80204cf2:	7606                	ld	a2,96(sp)
    80204cf4:	e194                	sd	a3,0(a1)
    80204cf6:	e590                	sd	a2,8(a1)

0000000080204cf8 <.Lpcrel_hi0>:
    80204cf8:	00003617          	auipc	a2,0x3
    80204cfc:	5f060613          	add	a2,a2,1520 # 802082e8 <.L__unnamed_1>
    80204d00:	f190                	sd	a2,32(a1)
    80204d02:	f588                	sd	a0,40(a1)
    80204d04:	70e6                	ld	ra,120(sp)
    80204d06:	6109                	add	sp,sp,128
    80204d08:	8082                	ret

0000000080204d0a <.Lpcrel_hi1>:
    80204d0a:	00003517          	auipc	a0,0x3
    80204d0e:	56650593          	add	a1,a0,1382 # 80208270 <.L__unnamed_2>
    80204d12:	1028                	add	a0,sp,40
    80204d14:	e42a                	sd	a0,8(sp)
    80204d16:	4605                	li	a2,1
    80204d18:	00000097          	auipc	ra,0x0
    80204d1c:	fb4080e7          	jalr	-76(ra) # 80204ccc <_ZN4core3fmt9Arguments9new_const17h995a7079db2e21b4E>
    80204d20:	6522                	ld	a0,8(sp)

0000000080204d22 <.Lpcrel_hi2>:
    80204d22:	00003597          	auipc	a1,0x3
    80204d26:	5ae58593          	add	a1,a1,1454 # 802082d0 <.L__unnamed_3>
    80204d2a:	00001097          	auipc	ra,0x1
    80204d2e:	802080e7          	jalr	-2046(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204d34 <_ZN4core4sync6atomic12atomic_store17h093b066d284101fdE>:
    80204d34:	7171                	add	sp,sp,-176
    80204d36:	f506                	sd	ra,168(sp)
    80204d38:	ec2a                	sd	a0,24(sp)
    80204d3a:	86ae                	mv	a3,a1
    80204d3c:	f036                	sd	a3,32(sp)
    80204d3e:	02c10ba3          	sb	a2,55(sp)
    80204d42:	ed2a                	sd	a0,152(sp)
    80204d44:	0ab103a3          	sb	a1,167(sp)
    80204d48:	03714503          	lbu	a0,55(sp)
    80204d4c:	f42a                	sd	a0,40(sp)
    80204d4e:	7522                	ld	a0,40(sp)
    80204d50:	050e                	sll	a0,a0,0x3

0000000080204d52 <.Lpcrel_hi0>:
    80204d52:	00003597          	auipc	a1,0x3
    80204d56:	59658593          	add	a1,a1,1430 # 802082e8 <.L__unnamed_1>
    80204d5a:	952e                	add	a0,a0,a1
    80204d5c:	6108                	ld	a0,0(a0)
    80204d5e:	8502                	jr	a0
	...

0000000080204d62 <.LBB0_3>:
    80204d62:	7502                	ld	a0,32(sp)
    80204d64:	65e2                	ld	a1,24(sp)
    80204d66:	00a58023          	sb	a0,0(a1)
    80204d6a:	a88d                	j	80204ddc <.LBB0_7+0xe>

0000000080204d6c <.LBB0_4>:
    80204d6c:	7502                	ld	a0,32(sp)
    80204d6e:	65e2                	ld	a1,24(sp)
    80204d70:	0310000f          	fence	rw,w
    80204d74:	00a58023          	sb	a0,0(a1)
    80204d78:	a095                	j	80204ddc <.LBB0_7+0xe>

0000000080204d7a <.LBB0_5>:
    80204d7a:	00003517          	auipc	a0,0x3
    80204d7e:	67650593          	add	a1,a0,1654 # 802083f0 <.L__unnamed_1>
    80204d82:	1828                	add	a0,sp,56
    80204d84:	e82a                	sd	a0,16(sp)
    80204d86:	4605                	li	a2,1
    80204d88:	00000097          	auipc	ra,0x0
    80204d8c:	064080e7          	jalr	100(ra) # 80204dec <_ZN4core3fmt9Arguments9new_const17ha7e9cbdeba2a4299E>
    80204d90:	6542                	ld	a0,16(sp)

0000000080204d92 <.Lpcrel_hi2>:
    80204d92:	00003597          	auipc	a1,0x3
    80204d96:	66e58593          	add	a1,a1,1646 # 80208400 <.L__unnamed_2>
    80204d9a:	00000097          	auipc	ra,0x0
    80204d9e:	792080e7          	jalr	1938(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204da4 <.LBB0_6>:
    80204da4:	00003517          	auipc	a0,0x3
    80204da8:	5a450593          	add	a1,a0,1444 # 80208348 <.L__unnamed_3>
    80204dac:	10a8                	add	a0,sp,104
    80204dae:	e42a                	sd	a0,8(sp)
    80204db0:	4605                	li	a2,1
    80204db2:	00000097          	auipc	ra,0x0
    80204db6:	03a080e7          	jalr	58(ra) # 80204dec <_ZN4core3fmt9Arguments9new_const17ha7e9cbdeba2a4299E>
    80204dba:	6522                	ld	a0,8(sp)

0000000080204dbc <.Lpcrel_hi4>:
    80204dbc:	00003597          	auipc	a1,0x3
    80204dc0:	5ec58593          	add	a1,a1,1516 # 802083a8 <.L__unnamed_4>
    80204dc4:	00000097          	auipc	ra,0x0
    80204dc8:	768080e7          	jalr	1896(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204dce <.LBB0_7>:
    80204dce:	7502                	ld	a0,32(sp)
    80204dd0:	65e2                	ld	a1,24(sp)
    80204dd2:	0310000f          	fence	rw,w
    80204dd6:	00a58023          	sb	a0,0(a1)
    80204dda:	a009                	j	80204ddc <.LBB0_7+0xe>
    80204ddc:	70aa                	ld	ra,168(sp)
    80204dde:	614d                	add	sp,sp,176
    80204de0:	8082                	ret

0000000080204de2 <_ZN4spin4once6status6Status13new_unchecked17hf2ea35bf08e2abdfE>:
    80204de2:	1141                	add	sp,sp,-16
    80204de4:	00a107a3          	sb	a0,15(sp)
    80204de8:	0141                	add	sp,sp,16
    80204dea:	8082                	ret

0000000080204dec <_ZN4core3fmt9Arguments9new_const17ha7e9cbdeba2a4299E>:
    80204dec:	7119                	add	sp,sp,-128
    80204dee:	fc86                	sd	ra,120(sp)
    80204df0:	e832                	sd	a2,16(sp)
    80204df2:	ec2e                	sd	a1,24(sp)
    80204df4:	f02a                	sd	a0,32(sp)
    80204df6:	f4ae                	sd	a1,104(sp)
    80204df8:	f8b2                	sd	a2,112(sp)
    80204dfa:	4505                	li	a0,1
    80204dfc:	02c56763          	bltu	a0,a2,80204e2a <.Lpcrel_hi1>
    80204e00:	a009                	j	80204e02 <_ZN4core3fmt9Arguments9new_const17ha7e9cbdeba2a4299E+0x16>
    80204e02:	7582                	ld	a1,32(sp)
    80204e04:	6642                	ld	a2,16(sp)
    80204e06:	66e2                	ld	a3,24(sp)
    80204e08:	4501                	li	a0,0
    80204e0a:	ecaa                	sd	a0,88(sp)
    80204e0c:	e994                	sd	a3,16(a1)
    80204e0e:	ed90                	sd	a2,24(a1)
    80204e10:	66e6                	ld	a3,88(sp)
    80204e12:	7606                	ld	a2,96(sp)
    80204e14:	e194                	sd	a3,0(a1)
    80204e16:	e590                	sd	a2,8(a1)

0000000080204e18 <.Lpcrel_hi0>:
    80204e18:	00003617          	auipc	a2,0x3
    80204e1c:	68860613          	add	a2,a2,1672 # 802084a0 <.L__unnamed_1>
    80204e20:	f190                	sd	a2,32(a1)
    80204e22:	f588                	sd	a0,40(a1)
    80204e24:	70e6                	ld	ra,120(sp)
    80204e26:	6109                	add	sp,sp,128
    80204e28:	8082                	ret

0000000080204e2a <.Lpcrel_hi1>:
    80204e2a:	00003517          	auipc	a0,0x3
    80204e2e:	5fe50593          	add	a1,a0,1534 # 80208428 <.L__unnamed_2>
    80204e32:	1028                	add	a0,sp,40
    80204e34:	e42a                	sd	a0,8(sp)
    80204e36:	4605                	li	a2,1
    80204e38:	00000097          	auipc	ra,0x0
    80204e3c:	fb4080e7          	jalr	-76(ra) # 80204dec <_ZN4core3fmt9Arguments9new_const17ha7e9cbdeba2a4299E>
    80204e40:	6522                	ld	a0,8(sp)

0000000080204e42 <.Lpcrel_hi2>:
    80204e42:	00003597          	auipc	a1,0x3
    80204e46:	64658593          	add	a1,a1,1606 # 80208488 <.L__unnamed_3>
    80204e4a:	00000097          	auipc	ra,0x0
    80204e4e:	6e2080e7          	jalr	1762(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080204e54 <_run_guest>:
    80204e54:	00153423          	sd	ra,8(a0)
    80204e58:	00353c23          	sd	gp,24(a0)
    80204e5c:	02453023          	sd	tp,32(a0)
    80204e60:	e120                	sd	s0,64(a0)
    80204e62:	e524                	sd	s1,72(a0)
    80204e64:	ed2c                	sd	a1,88(a0)
    80204e66:	f130                	sd	a2,96(a0)
    80204e68:	f534                	sd	a3,104(a0)
    80204e6a:	f938                	sd	a4,112(a0)
    80204e6c:	fd3c                	sd	a5,120(a0)
    80204e6e:	09053023          	sd	a6,128(a0)
    80204e72:	09153423          	sd	a7,136(a0)
    80204e76:	09253823          	sd	s2,144(a0)
    80204e7a:	09353c23          	sd	s3,152(a0)
    80204e7e:	0b453023          	sd	s4,160(a0)
    80204e82:	0b553423          	sd	s5,168(a0)
    80204e86:	0b653823          	sd	s6,176(a0)
    80204e8a:	0b753c23          	sd	s7,184(a0)
    80204e8e:	0d853023          	sd	s8,192(a0)
    80204e92:	0d953423          	sd	s9,200(a0)
    80204e96:	0da53823          	sd	s10,208(a0)
    80204e9a:	0db53c23          	sd	s11,216(a0)
    80204e9e:	00253823          	sd	sp,16(a0)
    80204ea2:	22853303          	ld	t1,552(a0)
    80204ea6:	10031373          	csrrw	t1,sstatus,t1
    80204eaa:	10653023          	sd	t1,256(a0)
    80204eae:	23053303          	ld	t1,560(a0)
    80204eb2:	60031373          	csrrw	t1,hstatus,t1
    80204eb6:	10653423          	sd	t1,264(a0)
    80204eba:	23853303          	ld	t1,568(a0)
    80204ebe:	10631373          	csrrw	t1,scounteren,t1
    80204ec2:	10653823          	sd	t1,272(a0)
    80204ec6:	24053303          	ld	t1,576(a0)
    80204eca:	14131073          	csrw	sepc,t1
    80204ece:	00000317          	auipc	t1,0x0
    80204ed2:	09a30313          	add	t1,t1,154 # 80204f68 <_guest_exit>
    80204ed6:	10531373          	csrrw	t1,stvec,t1
    80204eda:	10653c23          	sd	t1,280(a0)
    80204ede:	14051373          	csrrw	t1,sscratch,a0
    80204ee2:	12653023          	sd	t1,288(a0)
    80204ee6:	13053083          	ld	ra,304(a0)
    80204eea:	14053183          	ld	gp,320(a0)
    80204eee:	14853203          	ld	tp,328(a0)
    80204ef2:	16853403          	ld	s0,360(a0)
    80204ef6:	17053483          	ld	s1,368(a0)
    80204efa:	18053583          	ld	a1,384(a0)
    80204efe:	18853603          	ld	a2,392(a0)
    80204f02:	19053683          	ld	a3,400(a0)
    80204f06:	19853703          	ld	a4,408(a0)
    80204f0a:	1a053783          	ld	a5,416(a0)
    80204f0e:	1a853803          	ld	a6,424(a0)
    80204f12:	1b053883          	ld	a7,432(a0)
    80204f16:	1b853903          	ld	s2,440(a0)
    80204f1a:	1c053983          	ld	s3,448(a0)
    80204f1e:	1c853a03          	ld	s4,456(a0)
    80204f22:	1d053a83          	ld	s5,464(a0)
    80204f26:	1d853b03          	ld	s6,472(a0)
    80204f2a:	1e053b83          	ld	s7,480(a0)
    80204f2e:	1e853c03          	ld	s8,488(a0)
    80204f32:	1f053c83          	ld	s9,496(a0)
    80204f36:	1f853d03          	ld	s10,504(a0)
    80204f3a:	20053d83          	ld	s11,512(a0)
    80204f3e:	15053283          	ld	t0,336(a0)
    80204f42:	15853303          	ld	t1,344(a0)
    80204f46:	16053383          	ld	t2,352(a0)
    80204f4a:	20853e03          	ld	t3,520(a0)
    80204f4e:	21053e83          	ld	t4,528(a0)
    80204f52:	21853f03          	ld	t5,536(a0)
    80204f56:	22053f83          	ld	t6,544(a0)
    80204f5a:	13853103          	ld	sp,312(a0)
    80204f5e:	17853503          	ld	a0,376(a0)
    80204f62:	10200073          	sret
    80204f66:	0001                	nop

0000000080204f68 <_guest_exit>:
    80204f68:	14051573          	csrrw	a0,sscratch,a0
    80204f6c:	12153823          	sd	ra,304(a0)
    80204f70:	14353023          	sd	gp,320(a0)
    80204f74:	14453423          	sd	tp,328(a0)
    80204f78:	16853423          	sd	s0,360(a0)
    80204f7c:	16953823          	sd	s1,368(a0)
    80204f80:	18b53023          	sd	a1,384(a0)
    80204f84:	18c53423          	sd	a2,392(a0)
    80204f88:	18d53823          	sd	a3,400(a0)
    80204f8c:	18e53c23          	sd	a4,408(a0)
    80204f90:	1af53023          	sd	a5,416(a0)
    80204f94:	1b053423          	sd	a6,424(a0)
    80204f98:	1b153823          	sd	a7,432(a0)
    80204f9c:	1b253c23          	sd	s2,440(a0)
    80204fa0:	1d353023          	sd	s3,448(a0)
    80204fa4:	1d453423          	sd	s4,456(a0)
    80204fa8:	1d553823          	sd	s5,464(a0)
    80204fac:	1d653c23          	sd	s6,472(a0)
    80204fb0:	1f753023          	sd	s7,480(a0)
    80204fb4:	1f853423          	sd	s8,488(a0)
    80204fb8:	1f953823          	sd	s9,496(a0)
    80204fbc:	1fa53c23          	sd	s10,504(a0)
    80204fc0:	21b53023          	sd	s11,512(a0)
    80204fc4:	14553823          	sd	t0,336(a0)
    80204fc8:	14653c23          	sd	t1,344(a0)
    80204fcc:	16753023          	sd	t2,352(a0)
    80204fd0:	21c53423          	sd	t3,520(a0)
    80204fd4:	21d53823          	sd	t4,528(a0)
    80204fd8:	21e53c23          	sd	t5,536(a0)
    80204fdc:	23f53023          	sd	t6,544(a0)
    80204fe0:	12253c23          	sd	sp,312(a0)
    80204fe4:	140022f3          	csrr	t0,sscratch
    80204fe8:	16553c23          	sd	t0,376(a0)

0000000080204fec <_restore_csrs>:
    80204fec:	10053303          	ld	t1,256(a0)
    80204ff0:	10031373          	csrrw	t1,sstatus,t1
    80204ff4:	22653423          	sd	t1,552(a0)
    80204ff8:	10853303          	ld	t1,264(a0)
    80204ffc:	60031373          	csrrw	t1,hstatus,t1
    80205000:	22653823          	sd	t1,560(a0)
    80205004:	11053303          	ld	t1,272(a0)
    80205008:	10631373          	csrrw	t1,scounteren,t1
    8020500c:	22653c23          	sd	t1,568(a0)
    80205010:	11853303          	ld	t1,280(a0)
    80205014:	10531073          	csrw	stvec,t1
    80205018:	12053303          	ld	t1,288(a0)
    8020501c:	14031073          	csrw	sscratch,t1
    80205020:	14102373          	csrr	t1,sepc
    80205024:	24653023          	sd	t1,576(a0)
    80205028:	00853083          	ld	ra,8(a0)
    8020502c:	01853183          	ld	gp,24(a0)
    80205030:	02053203          	ld	tp,32(a0)
    80205034:	6120                	ld	s0,64(a0)
    80205036:	6524                	ld	s1,72(a0)
    80205038:	6d2c                	ld	a1,88(a0)
    8020503a:	7130                	ld	a2,96(a0)
    8020503c:	7534                	ld	a3,104(a0)
    8020503e:	7938                	ld	a4,112(a0)
    80205040:	7d3c                	ld	a5,120(a0)
    80205042:	08053803          	ld	a6,128(a0)
    80205046:	08853883          	ld	a7,136(a0)
    8020504a:	09053903          	ld	s2,144(a0)
    8020504e:	09853983          	ld	s3,152(a0)
    80205052:	0a053a03          	ld	s4,160(a0)
    80205056:	0a853a83          	ld	s5,168(a0)
    8020505a:	0b053b03          	ld	s6,176(a0)
    8020505e:	0b853b83          	ld	s7,184(a0)
    80205062:	0c053c03          	ld	s8,192(a0)
    80205066:	0c853c83          	ld	s9,200(a0)
    8020506a:	0d053d03          	ld	s10,208(a0)
    8020506e:	0d853d83          	ld	s11,216(a0)
    80205072:	01053103          	ld	sp,16(a0)
    80205076:	8082                	ret

0000000080205078 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3fa30067391091f6E>:
    80205078:	1101                	add	sp,sp,-32
    8020507a:	ec06                	sd	ra,24(sp)
    8020507c:	e42a                	sd	a0,8(sp)
    8020507e:	e82e                	sd	a1,16(sp)
    80205080:	6108                	ld	a0,0(a0)
    80205082:	00000097          	auipc	ra,0x0
    80205086:	33a080e7          	jalr	826(ra) # 802053bc <_ZN71_$LT$riscv..register..scause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17hf9ea8b3a98831aa7E>
    8020508a:	60e2                	ld	ra,24(sp)
    8020508c:	6105                	add	sp,sp,32
    8020508e:	8082                	ret

0000000080205090 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h98d7f5982d08aed3E>:
    80205090:	1101                	add	sp,sp,-32
    80205092:	ec06                	sd	ra,24(sp)
    80205094:	e42a                	sd	a0,8(sp)
    80205096:	e82e                	sd	a1,16(sp)
    80205098:	6108                	ld	a0,0(a0)
    8020509a:	00000097          	auipc	ra,0x0
    8020509e:	24a080e7          	jalr	586(ra) # 802052e4 <_ZN71_$LT$riscv..register..scause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17ha549c3d393fe6c1bE>
    802050a2:	60e2                	ld	ra,24(sp)
    802050a4:	6105                	add	sp,sp,32
    802050a6:	8082                	ret

00000000802050a8 <_ZN5riscv8register6scause9Interrupt4from17h3f999344874153e2E>:
    802050a8:	1101                	add	sp,sp,-32
    802050aa:	85aa                	mv	a1,a0
    802050ac:	ec2e                	sd	a1,24(sp)
    802050ae:	852e                	mv	a0,a1
    802050b0:	e42a                	sd	a0,8(sp)
    802050b2:	4529                	li	a0,10
    802050b4:	00b56b63          	bltu	a0,a1,802050ca <.LBB2_2>
    802050b8:	6522                	ld	a0,8(sp)
    802050ba:	050e                	sll	a0,a0,0x3

00000000802050bc <.Lpcrel_hi0>:
    802050bc:	00003597          	auipc	a1,0x3
    802050c0:	3e458593          	add	a1,a1,996 # 802084a0 <.L__unnamed_1>
    802050c4:	952e                	add	a0,a0,a1
    802050c6:	6108                	ld	a0,0(a0)
    802050c8:	8502                	jr	a0

00000000802050ca <.LBB2_2>:
    802050ca:	4525                	li	a0,9
    802050cc:	00a10ba3          	sb	a0,23(sp)
    802050d0:	a0a9                	j	8020511a <.LBB2_11+0x8>

00000000802050d2 <.LBB2_3>:
    802050d2:	4501                	li	a0,0
    802050d4:	00a10ba3          	sb	a0,23(sp)
    802050d8:	a089                	j	8020511a <.LBB2_11+0x8>

00000000802050da <.LBB2_4>:
    802050da:	4509                	li	a0,2
    802050dc:	00a10ba3          	sb	a0,23(sp)
    802050e0:	a82d                	j	8020511a <.LBB2_11+0x8>

00000000802050e2 <.LBB2_5>:
    802050e2:	4505                	li	a0,1
    802050e4:	00a10ba3          	sb	a0,23(sp)
    802050e8:	a80d                	j	8020511a <.LBB2_11+0x8>

00000000802050ea <.LBB2_6>:
    802050ea:	450d                	li	a0,3
    802050ec:	00a10ba3          	sb	a0,23(sp)
    802050f0:	a02d                	j	8020511a <.LBB2_11+0x8>

00000000802050f2 <.LBB2_7>:
    802050f2:	4515                	li	a0,5
    802050f4:	00a10ba3          	sb	a0,23(sp)
    802050f8:	a00d                	j	8020511a <.LBB2_11+0x8>

00000000802050fa <.LBB2_8>:
    802050fa:	4511                	li	a0,4
    802050fc:	00a10ba3          	sb	a0,23(sp)
    80205100:	a829                	j	8020511a <.LBB2_11+0x8>

0000000080205102 <.LBB2_9>:
    80205102:	4519                	li	a0,6
    80205104:	00a10ba3          	sb	a0,23(sp)
    80205108:	a809                	j	8020511a <.LBB2_11+0x8>

000000008020510a <.LBB2_10>:
    8020510a:	4521                	li	a0,8
    8020510c:	00a10ba3          	sb	a0,23(sp)
    80205110:	a029                	j	8020511a <.LBB2_11+0x8>

0000000080205112 <.LBB2_11>:
    80205112:	451d                	li	a0,7
    80205114:	00a10ba3          	sb	a0,23(sp)
    80205118:	a009                	j	8020511a <.LBB2_11+0x8>
    8020511a:	01710503          	lb	a0,23(sp)
    8020511e:	6105                	add	sp,sp,32
    80205120:	8082                	ret

0000000080205122 <_ZN5riscv8register6scause9Exception4from17h1eca99df968464caE>:
    80205122:	1101                	add	sp,sp,-32
    80205124:	85aa                	mv	a1,a0
    80205126:	ec2e                	sd	a1,24(sp)
    80205128:	852e                	mv	a0,a1
    8020512a:	e42a                	sd	a0,8(sp)
    8020512c:	455d                	li	a0,23
    8020512e:	00b56b63          	bltu	a0,a1,80205144 <.LBB3_2>
    80205132:	6522                	ld	a0,8(sp)
    80205134:	050e                	sll	a0,a0,0x3

0000000080205136 <.Lpcrel_hi1>:
    80205136:	00003597          	auipc	a1,0x3
    8020513a:	3c258593          	add	a1,a1,962 # 802084f8 <.LJTI3_0>
    8020513e:	952e                	add	a0,a0,a1
    80205140:	6108                	ld	a0,0(a0)
    80205142:	8502                	jr	a0

0000000080205144 <.LBB3_2>:
    80205144:	4541                	li	a0,16
    80205146:	00a10ba3          	sb	a0,23(sp)
    8020514a:	a049                	j	802051cc <.LBB3_18+0x8>

000000008020514c <.LBB3_3>:
    8020514c:	4501                	li	a0,0
    8020514e:	00a10ba3          	sb	a0,23(sp)
    80205152:	a8ad                	j	802051cc <.LBB3_18+0x8>

0000000080205154 <.LBB3_4>:
    80205154:	4505                	li	a0,1
    80205156:	00a10ba3          	sb	a0,23(sp)
    8020515a:	a88d                	j	802051cc <.LBB3_18+0x8>

000000008020515c <.LBB3_5>:
    8020515c:	4509                	li	a0,2
    8020515e:	00a10ba3          	sb	a0,23(sp)
    80205162:	a0ad                	j	802051cc <.LBB3_18+0x8>

0000000080205164 <.LBB3_6>:
    80205164:	450d                	li	a0,3
    80205166:	00a10ba3          	sb	a0,23(sp)
    8020516a:	a08d                	j	802051cc <.LBB3_18+0x8>

000000008020516c <.LBB3_7>:
    8020516c:	4511                	li	a0,4
    8020516e:	00a10ba3          	sb	a0,23(sp)
    80205172:	a8a9                	j	802051cc <.LBB3_18+0x8>

0000000080205174 <.LBB3_8>:
    80205174:	4515                	li	a0,5
    80205176:	00a10ba3          	sb	a0,23(sp)
    8020517a:	a889                	j	802051cc <.LBB3_18+0x8>

000000008020517c <.LBB3_9>:
    8020517c:	4519                	li	a0,6
    8020517e:	00a10ba3          	sb	a0,23(sp)
    80205182:	a0a9                	j	802051cc <.LBB3_18+0x8>

0000000080205184 <.LBB3_10>:
    80205184:	451d                	li	a0,7
    80205186:	00a10ba3          	sb	a0,23(sp)
    8020518a:	a089                	j	802051cc <.LBB3_18+0x8>

000000008020518c <.LBB3_11>:
    8020518c:	4521                	li	a0,8
    8020518e:	00a10ba3          	sb	a0,23(sp)
    80205192:	a82d                	j	802051cc <.LBB3_18+0x8>

0000000080205194 <.LBB3_12>:
    80205194:	4525                	li	a0,9
    80205196:	00a10ba3          	sb	a0,23(sp)
    8020519a:	a80d                	j	802051cc <.LBB3_18+0x8>

000000008020519c <.LBB3_13>:
    8020519c:	4529                	li	a0,10
    8020519e:	00a10ba3          	sb	a0,23(sp)
    802051a2:	a02d                	j	802051cc <.LBB3_18+0x8>

00000000802051a4 <.LBB3_14>:
    802051a4:	452d                	li	a0,11
    802051a6:	00a10ba3          	sb	a0,23(sp)
    802051aa:	a00d                	j	802051cc <.LBB3_18+0x8>

00000000802051ac <.LBB3_15>:
    802051ac:	4531                	li	a0,12
    802051ae:	00a10ba3          	sb	a0,23(sp)
    802051b2:	a829                	j	802051cc <.LBB3_18+0x8>

00000000802051b4 <.LBB3_16>:
    802051b4:	4535                	li	a0,13
    802051b6:	00a10ba3          	sb	a0,23(sp)
    802051ba:	a809                	j	802051cc <.LBB3_18+0x8>

00000000802051bc <.LBB3_17>:
    802051bc:	4539                	li	a0,14
    802051be:	00a10ba3          	sb	a0,23(sp)
    802051c2:	a029                	j	802051cc <.LBB3_18+0x8>

00000000802051c4 <.LBB3_18>:
    802051c4:	453d                	li	a0,15
    802051c6:	00a10ba3          	sb	a0,23(sp)
    802051ca:	a009                	j	802051cc <.LBB3_18+0x8>
    802051cc:	01710503          	lb	a0,23(sp)
    802051d0:	6105                	add	sp,sp,32
    802051d2:	8082                	ret

00000000802051d4 <_ZN5riscv8register6scause6Scause4code17h54ee637b5702fa83E>:
    802051d4:	7179                	add	sp,sp,-48
    802051d6:	e82a                	sd	a0,16(sp)
    802051d8:	f02a                	sd	a0,32(sp)
    802051da:	04000513          	li	a0,64
    802051de:	ec2a                	sd	a0,24(sp)
    802051e0:	4501                	li	a0,0
    802051e2:	e901                	bnez	a0,802051f2 <.Lpcrel_hi2>
    802051e4:	a009                	j	802051e6 <_ZN5riscv8register6scause6Scause4code17h54ee637b5702fa83E+0x12>
    802051e6:	6562                	ld	a0,24(sp)
    802051e8:	fff50593          	add	a1,a0,-1
    802051ec:	e42e                	sd	a1,8(sp)
    802051ee:	c51d                	beqz	a0,8020521c <.Lpcrel_hi4>
    802051f0:	a005                	j	80205210 <.Lpcrel_hi3+0x16>

00000000802051f2 <.Lpcrel_hi2>:
    802051f2:	00003517          	auipc	a0,0x3
    802051f6:	51e50513          	add	a0,a0,1310 # 80208710 <str.0>

00000000802051fa <.Lpcrel_hi3>:
    802051fa:	00003597          	auipc	a1,0x3
    802051fe:	4f658613          	add	a2,a1,1270 # 802086f0 <.L__unnamed_3>
    80205202:	02100593          	li	a1,33
    80205206:	00000097          	auipc	ra,0x0
    8020520a:	354080e7          	jalr	852(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    8020520e:	0000                	unimp
    80205210:	6522                	ld	a0,8(sp)
    80205212:	04000593          	li	a1,64
    80205216:	02b56263          	bltu	a0,a1,8020523a <.Lpcrel_hi5+0x16>
    8020521a:	a825                	j	80205252 <.Lpcrel_hi6>

000000008020521c <.Lpcrel_hi4>:
    8020521c:	00003517          	auipc	a0,0x3
    80205220:	53450513          	add	a0,a0,1332 # 80208750 <str.1>

0000000080205224 <.Lpcrel_hi5>:
    80205224:	00003597          	auipc	a1,0x3
    80205228:	51458613          	add	a2,a1,1300 # 80208738 <.L__unnamed_4>
    8020522c:	02100593          	li	a1,33
    80205230:	00000097          	auipc	ra,0x0
    80205234:	32a080e7          	jalr	810(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
    80205238:	0000                	unimp
    8020523a:	6542                	ld	a0,16(sp)
    8020523c:	6622                	ld	a2,8(sp)
    8020523e:	4585                	li	a1,1
    80205240:	00c595b3          	sll	a1,a1,a2
    80205244:	f42e                	sd	a1,40(sp)
    80205246:	6108                	ld	a0,0(a0)
    80205248:	fff5c593          	not	a1,a1
    8020524c:	8d6d                	and	a0,a0,a1
    8020524e:	6145                	add	sp,sp,48
    80205250:	8082                	ret

0000000080205252 <.Lpcrel_hi6>:
    80205252:	00003517          	auipc	a0,0x3
    80205256:	53e50513          	add	a0,a0,1342 # 80208790 <str.2>

000000008020525a <.Lpcrel_hi7>:
    8020525a:	00003597          	auipc	a1,0x3
    8020525e:	51e58613          	add	a2,a1,1310 # 80208778 <.L__unnamed_5>
    80205262:	02300593          	li	a1,35
    80205266:	00000097          	auipc	ra,0x0
    8020526a:	2f4080e7          	jalr	756(ra) # 8020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>
	...

0000000080205270 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h6a04807329fcac14E>:
    80205270:	7139                	add	sp,sp,-64
    80205272:	fc06                	sd	ra,56(sp)
    80205274:	e02e                	sd	a1,0(sp)
    80205276:	e42a                	sd	a0,8(sp)
    80205278:	f42a                	sd	a0,40(sp)
    8020527a:	f82e                	sd	a1,48(sp)
    8020527c:	00054503          	lbu	a0,0(a0)
    80205280:	8905                	and	a0,a0,1
    80205282:	e51d                	bnez	a0,802052b0 <.Lpcrel_hi9+0x1a>
    80205284:	a009                	j	80205286 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h6a04807329fcac14E+0x16>
    80205286:	6502                	ld	a0,0(sp)
    80205288:	65a2                	ld	a1,8(sp)
    8020528a:	0585                	add	a1,a1,1
    8020528c:	ec2e                	sd	a1,24(sp)

000000008020528e <.Lpcrel_hi8>:
    8020528e:	00003597          	auipc	a1,0x3
    80205292:	55258593          	add	a1,a1,1362 # 802087e0 <.L__unnamed_6>

0000000080205296 <.Lpcrel_hi9>:
    80205296:	00003617          	auipc	a2,0x3
    8020529a:	55a60713          	add	a4,a2,1370 # 802087f0 <.L__unnamed_2>
    8020529e:	4625                	li	a2,9
    802052a0:	0834                	add	a3,sp,24
    802052a2:	00001097          	auipc	ra,0x1
    802052a6:	e66080e7          	jalr	-410(ra) # 80206108 <_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h44ef5ce4a1577e92E>
    802052aa:	00a10ba3          	sb	a0,23(sp)
    802052ae:	a035                	j	802052da <.Lpcrel_hi11+0x1a>
    802052b0:	6502                	ld	a0,0(sp)
    802052b2:	65a2                	ld	a1,8(sp)
    802052b4:	0585                	add	a1,a1,1
    802052b6:	f02e                	sd	a1,32(sp)

00000000802052b8 <.Lpcrel_hi10>:
    802052b8:	00003597          	auipc	a1,0x3
    802052bc:	4fb58593          	add	a1,a1,1275 # 802087b3 <.L__unnamed_7>

00000000802052c0 <.Lpcrel_hi11>:
    802052c0:	00003617          	auipc	a2,0x3
    802052c4:	50060713          	add	a4,a2,1280 # 802087c0 <.L__unnamed_1>
    802052c8:	4625                	li	a2,9
    802052ca:	1014                	add	a3,sp,32
    802052cc:	00001097          	auipc	ra,0x1
    802052d0:	e3c080e7          	jalr	-452(ra) # 80206108 <_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h44ef5ce4a1577e92E>
    802052d4:	00a10ba3          	sb	a0,23(sp)
    802052d8:	a009                	j	802052da <.Lpcrel_hi11+0x1a>
    802052da:	01714503          	lbu	a0,23(sp)
    802052de:	70e2                	ld	ra,56(sp)
    802052e0:	6121                	add	sp,sp,64
    802052e2:	8082                	ret

00000000802052e4 <_ZN71_$LT$riscv..register..scause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17ha549c3d393fe6c1bE>:
    802052e4:	7139                	add	sp,sp,-64
    802052e6:	fc06                	sd	ra,56(sp)
    802052e8:	e42e                	sd	a1,8(sp)
    802052ea:	f42a                	sd	a0,40(sp)
    802052ec:	f82e                	sd	a1,48(sp)
    802052ee:	00054503          	lbu	a0,0(a0)
    802052f2:	e82a                	sd	a0,16(sp)
    802052f4:	6542                	ld	a0,16(sp)
    802052f6:	050e                	sll	a0,a0,0x3

00000000802052f8 <.Lpcrel_hi12>:
    802052f8:	00003597          	auipc	a1,0x3
    802052fc:	2c058593          	add	a1,a1,704 # 802085b8 <.LJTI6_0>
    80205300:	952e                	add	a0,a0,a1
    80205302:	6108                	ld	a0,0(a0)
    80205304:	8502                	jr	a0
	...

0000000080205308 <.LBB6_3>:
    80205308:	00003517          	auipc	a0,0x3
    8020530c:	59750513          	add	a0,a0,1431 # 8020889f <.L__unnamed_9+0x15>
    80205310:	ec2a                	sd	a0,24(sp)
    80205312:	4521                	li	a0,8
    80205314:	f02a                	sd	a0,32(sp)
    80205316:	a849                	j	802053a8 <.LBB6_12+0x10>

0000000080205318 <.LBB6_4>:
    80205318:	00003517          	auipc	a0,0x3
    8020531c:	57250513          	add	a0,a0,1394 # 8020888a <.L__unnamed_9>
    80205320:	ec2a                	sd	a0,24(sp)
    80205322:	4555                	li	a0,21
    80205324:	f02a                	sd	a0,32(sp)
    80205326:	a049                	j	802053a8 <.LBB6_12+0x10>

0000000080205328 <.LBB6_5>:
    80205328:	00003517          	auipc	a0,0x3
    8020532c:	55450513          	add	a0,a0,1364 # 8020887c <.L__unnamed_10>
    80205330:	ec2a                	sd	a0,24(sp)
    80205332:	4539                	li	a0,14
    80205334:	f02a                	sd	a0,32(sp)
    80205336:	a88d                	j	802053a8 <.LBB6_12+0x10>

0000000080205338 <.LBB6_6>:
    80205338:	00003517          	auipc	a0,0x3
    8020533c:	53b50513          	add	a0,a0,1339 # 80208873 <.L__unnamed_11>
    80205340:	ec2a                	sd	a0,24(sp)
    80205342:	4525                	li	a0,9
    80205344:	f02a                	sd	a0,32(sp)
    80205346:	a08d                	j	802053a8 <.LBB6_12+0x10>

0000000080205348 <.LBB6_7>:
    80205348:	00003517          	auipc	a0,0x3
    8020534c:	51550513          	add	a0,a0,1301 # 8020885d <.L__unnamed_12>
    80205350:	ec2a                	sd	a0,24(sp)
    80205352:	4559                	li	a0,22
    80205354:	f02a                	sd	a0,32(sp)
    80205356:	a889                	j	802053a8 <.LBB6_12+0x10>

0000000080205358 <.LBB6_8>:
    80205358:	00003517          	auipc	a0,0x3
    8020535c:	4f650513          	add	a0,a0,1270 # 8020884e <.L__unnamed_13>
    80205360:	ec2a                	sd	a0,24(sp)
    80205362:	453d                	li	a0,15
    80205364:	f02a                	sd	a0,32(sp)
    80205366:	a089                	j	802053a8 <.LBB6_12+0x10>

0000000080205368 <.LBB6_9>:
    80205368:	00003517          	auipc	a0,0x3
    8020536c:	4da50513          	add	a0,a0,1242 # 80208842 <.L__unnamed_14>
    80205370:	ec2a                	sd	a0,24(sp)
    80205372:	4531                	li	a0,12
    80205374:	f02a                	sd	a0,32(sp)
    80205376:	a80d                	j	802053a8 <.LBB6_12+0x10>

0000000080205378 <.LBB6_10>:
    80205378:	00003517          	auipc	a0,0x3
    8020537c:	4b150513          	add	a0,a0,1201 # 80208829 <.L__unnamed_15>
    80205380:	ec2a                	sd	a0,24(sp)
    80205382:	4565                	li	a0,25
    80205384:	f02a                	sd	a0,32(sp)
    80205386:	a00d                	j	802053a8 <.LBB6_12+0x10>

0000000080205388 <.LBB6_11>:
    80205388:	00003517          	auipc	a0,0x3
    8020538c:	48f50513          	add	a0,a0,1167 # 80208817 <.L__unnamed_16>
    80205390:	ec2a                	sd	a0,24(sp)
    80205392:	4549                	li	a0,18
    80205394:	f02a                	sd	a0,32(sp)
    80205396:	a809                	j	802053a8 <.LBB6_12+0x10>

0000000080205398 <.LBB6_12>:
    80205398:	00003517          	auipc	a0,0x3
    8020539c:	47850513          	add	a0,a0,1144 # 80208810 <.L__unnamed_17>
    802053a0:	ec2a                	sd	a0,24(sp)
    802053a2:	451d                	li	a0,7
    802053a4:	f02a                	sd	a0,32(sp)
    802053a6:	a009                	j	802053a8 <.LBB6_12+0x10>
    802053a8:	6522                	ld	a0,8(sp)
    802053aa:	65e2                	ld	a1,24(sp)
    802053ac:	7602                	ld	a2,32(sp)
    802053ae:	00001097          	auipc	ra,0x1
    802053b2:	d52080e7          	jalr	-686(ra) # 80206100 <_ZN4core3fmt9Formatter9write_str17h20c02ed242b40bdfE>
    802053b6:	70e2                	ld	ra,56(sp)
    802053b8:	6121                	add	sp,sp,64
    802053ba:	8082                	ret

00000000802053bc <_ZN71_$LT$riscv..register..scause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17hf9ea8b3a98831aa7E>:
    802053bc:	7139                	add	sp,sp,-64
    802053be:	fc06                	sd	ra,56(sp)
    802053c0:	e42e                	sd	a1,8(sp)
    802053c2:	f42a                	sd	a0,40(sp)
    802053c4:	f82e                	sd	a1,48(sp)
    802053c6:	00054503          	lbu	a0,0(a0)
    802053ca:	e82a                	sd	a0,16(sp)
    802053cc:	6542                	ld	a0,16(sp)
    802053ce:	050e                	sll	a0,a0,0x3

00000000802053d0 <.Lpcrel_hi23>:
    802053d0:	00003597          	auipc	a1,0x3
    802053d4:	23858593          	add	a1,a1,568 # 80208608 <.LJTI7_0>
    802053d8:	952e                	add	a0,a0,a1
    802053da:	6108                	ld	a0,0(a0)
    802053dc:	8502                	jr	a0
	...

00000000802053e0 <.LBB7_3>:
    802053e0:	00003517          	auipc	a0,0x3
    802053e4:	5af50513          	add	a0,a0,1455 # 8020898f <.L__unnamed_18>
    802053e8:	ec2a                	sd	a0,24(sp)
    802053ea:	4555                	li	a0,21
    802053ec:	f02a                	sd	a0,32(sp)
    802053ee:	a209                	j	802054f0 <.LBB7_19+0x10>

00000000802053f0 <.LBB7_4>:
    802053f0:	00002517          	auipc	a0,0x2
    802053f4:	01050513          	add	a0,a0,16 # 80207400 <.L__unnamed_1+0x50>
    802053f8:	ec2a                	sd	a0,24(sp)
    802053fa:	4541                	li	a0,16
    802053fc:	f02a                	sd	a0,32(sp)
    802053fe:	a8cd                	j	802054f0 <.LBB7_19+0x10>

0000000080205400 <.LBB7_5>:
    80205400:	00003517          	auipc	a0,0x3
    80205404:	57d50513          	add	a0,a0,1405 # 8020897d <.L__unnamed_20>
    80205408:	ec2a                	sd	a0,24(sp)
    8020540a:	4549                	li	a0,18
    8020540c:	f02a                	sd	a0,32(sp)
    8020540e:	a0cd                	j	802054f0 <.LBB7_19+0x10>

0000000080205410 <.LBB7_6>:
    80205410:	00003517          	auipc	a0,0x3
    80205414:	56350513          	add	a0,a0,1379 # 80208973 <.L__unnamed_21>
    80205418:	ec2a                	sd	a0,24(sp)
    8020541a:	4529                	li	a0,10
    8020541c:	f02a                	sd	a0,32(sp)
    8020541e:	a8c9                	j	802054f0 <.LBB7_19+0x10>

0000000080205420 <.LBB7_7>:
    80205420:	00003517          	auipc	a0,0x3
    80205424:	54a50513          	add	a0,a0,1354 # 8020896a <.L__unnamed_22>
    80205428:	ec2a                	sd	a0,24(sp)
    8020542a:	4525                	li	a0,9
    8020542c:	f02a                	sd	a0,32(sp)
    8020542e:	a0c9                	j	802054f0 <.LBB7_19+0x10>

0000000080205430 <.LBB7_8>:
    80205430:	00003517          	auipc	a0,0x3
    80205434:	52b50513          	add	a0,a0,1323 # 8020895b <.L__unnamed_23>
    80205438:	ec2a                	sd	a0,24(sp)
    8020543a:	453d                	li	a0,15
    8020543c:	f02a                	sd	a0,32(sp)
    8020543e:	a84d                	j	802054f0 <.LBB7_19+0x10>

0000000080205440 <.LBB7_9>:
    80205440:	00003517          	auipc	a0,0x3
    80205444:	51150513          	add	a0,a0,1297 # 80208951 <.L__unnamed_24>
    80205448:	ec2a                	sd	a0,24(sp)
    8020544a:	4529                	li	a0,10
    8020544c:	f02a                	sd	a0,32(sp)
    8020544e:	a04d                	j	802054f0 <.LBB7_19+0x10>

0000000080205450 <.LBB7_10>:
    80205450:	00003517          	auipc	a0,0x3
    80205454:	4f650513          	add	a0,a0,1270 # 80208946 <.L__unnamed_25>
    80205458:	ec2a                	sd	a0,24(sp)
    8020545a:	452d                	li	a0,11
    8020545c:	f02a                	sd	a0,32(sp)
    8020545e:	a849                	j	802054f0 <.LBB7_19+0x10>

0000000080205460 <.LBB7_11>:
    80205460:	00003517          	auipc	a0,0x3
    80205464:	4ce50513          	add	a0,a0,1230 # 8020892e <.L__unnamed_26>
    80205468:	ec2a                	sd	a0,24(sp)
    8020546a:	4561                	li	a0,24
    8020546c:	f02a                	sd	a0,32(sp)
    8020546e:	a049                	j	802054f0 <.LBB7_19+0x10>

0000000080205470 <.LBB7_12>:
    80205470:	00003517          	auipc	a0,0x3
    80205474:	4aa50513          	add	a0,a0,1194 # 8020891a <.L__unnamed_27>
    80205478:	ec2a                	sd	a0,24(sp)
    8020547a:	4551                	li	a0,20
    8020547c:	f02a                	sd	a0,32(sp)
    8020547e:	a88d                	j	802054f0 <.LBB7_19+0x10>

0000000080205480 <.LBB7_13>:
    80205480:	00003517          	auipc	a0,0x3
    80205484:	48d50513          	add	a0,a0,1165 # 8020890d <.L__unnamed_28>
    80205488:	ec2a                	sd	a0,24(sp)
    8020548a:	4535                	li	a0,13
    8020548c:	f02a                	sd	a0,32(sp)
    8020548e:	a08d                	j	802054f0 <.LBB7_19+0x10>

0000000080205490 <.LBB7_14>:
    80205490:	00003517          	auipc	a0,0x3
    80205494:	46f50513          	add	a0,a0,1135 # 802088ff <.L__unnamed_29>
    80205498:	ec2a                	sd	a0,24(sp)
    8020549a:	4539                	li	a0,14
    8020549c:	f02a                	sd	a0,32(sp)
    8020549e:	a889                	j	802054f0 <.LBB7_19+0x10>

00000000802054a0 <.LBB7_15>:
    802054a0:	00003517          	auipc	a0,0x3
    802054a4:	44650513          	add	a0,a0,1094 # 802088e6 <.L__unnamed_30>
    802054a8:	ec2a                	sd	a0,24(sp)
    802054aa:	4565                	li	a0,25
    802054ac:	f02a                	sd	a0,32(sp)
    802054ae:	a089                	j	802054f0 <.LBB7_19+0x10>

00000000802054b0 <.LBB7_16>:
    802054b0:	00003517          	auipc	a0,0x3
    802054b4:	42450513          	add	a0,a0,1060 # 802088d4 <.L__unnamed_31>
    802054b8:	ec2a                	sd	a0,24(sp)
    802054ba:	4549                	li	a0,18
    802054bc:	f02a                	sd	a0,32(sp)
    802054be:	a80d                	j	802054f0 <.LBB7_19+0x10>

00000000802054c0 <.LBB7_17>:
    802054c0:	00003517          	auipc	a0,0x3
    802054c4:	40250513          	add	a0,a0,1026 # 802088c2 <.L__unnamed_32>
    802054c8:	ec2a                	sd	a0,24(sp)
    802054ca:	4549                	li	a0,18
    802054cc:	f02a                	sd	a0,32(sp)
    802054ce:	a00d                	j	802054f0 <.LBB7_19+0x10>

00000000802054d0 <.LBB7_18>:
    802054d0:	00003517          	auipc	a0,0x3
    802054d4:	3df50513          	add	a0,a0,991 # 802088af <.L__unnamed_33>
    802054d8:	ec2a                	sd	a0,24(sp)
    802054da:	454d                	li	a0,19
    802054dc:	f02a                	sd	a0,32(sp)
    802054de:	a809                	j	802054f0 <.LBB7_19+0x10>

00000000802054e0 <.LBB7_19>:
    802054e0:	00003517          	auipc	a0,0x3
    802054e4:	33050513          	add	a0,a0,816 # 80208810 <.L__unnamed_17>
    802054e8:	ec2a                	sd	a0,24(sp)
    802054ea:	451d                	li	a0,7
    802054ec:	f02a                	sd	a0,32(sp)
    802054ee:	a009                	j	802054f0 <.LBB7_19+0x10>
    802054f0:	6522                	ld	a0,8(sp)
    802054f2:	65e2                	ld	a1,24(sp)
    802054f4:	7602                	ld	a2,32(sp)
    802054f6:	00001097          	auipc	ra,0x1
    802054fa:	c0a080e7          	jalr	-1014(ra) # 80206100 <_ZN4core3fmt9Formatter9write_str17h20c02ed242b40bdfE>
    802054fe:	70e2                	ld	ra,56(sp)
    80205500:	6121                	add	sp,sp,64
    80205502:	8082                	ret

0000000080205504 <_ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Exception$GT$17hc8c215a673166ed6E>:
    80205504:	1141                	add	sp,sp,-16
    80205506:	e42a                	sd	a0,8(sp)
    80205508:	0141                	add	sp,sp,16
    8020550a:	8082                	ret

000000008020550c <_ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Interrupt$GT$17h01c0a46ccc1b2ba5E>:
    8020550c:	1141                	add	sp,sp,-16
    8020550e:	e42a                	sd	a0,8(sp)
    80205510:	0141                	add	sp,sp,16
    80205512:	8082                	ret

0000000080205514 <_ZN4core3ops8function6FnOnce9call_once17h53b344e2509276bdE>:
    80205514:	6108                	ld	a0,0(a0)
    80205516:	a001                	j	80205516 <_ZN4core3ops8function6FnOnce9call_once17h53b344e2509276bdE+0x2>

0000000080205518 <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17hc2143502d2b63a54E>:
    80205518:	8082                	ret

000000008020551a <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf33383ceec8b0d3bE>:
    8020551a:	00005517          	auipc	a0,0x5
    8020551e:	c3653503          	ld	a0,-970(a0) # 8020a150 <.LCPI88_0>
    80205522:	8082                	ret

0000000080205524 <_ZN4core5panic10panic_info9PanicInfo7message17hb1db4e52e2d41520E>:
    80205524:	6908                	ld	a0,16(a0)
    80205526:	8082                	ret

0000000080205528 <_ZN4core5panic10panic_info9PanicInfo8location17ha4fbac901d44a7d3E>:
    80205528:	6d08                	ld	a0,24(a0)
    8020552a:	8082                	ret

000000008020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>:
    8020552c:	7179                	add	sp,sp,-48
    8020552e:	f406                	sd	ra,40(sp)

0000000080205530 <.Lpcrel_hi458>:
    80205530:	00003617          	auipc	a2,0x3
    80205534:	47860613          	add	a2,a2,1144 # 802089a8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.156>
    80205538:	e032                	sd	a2,0(sp)

000000008020553a <.Lpcrel_hi459>:
    8020553a:	00003617          	auipc	a2,0x3
    8020553e:	47660613          	add	a2,a2,1142 # 802089b0 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.264>
    80205542:	e432                	sd	a2,8(sp)
    80205544:	e82a                	sd	a0,16(sp)
    80205546:	ec2e                	sd	a1,24(sp)
    80205548:	4505                	li	a0,1
    8020554a:	02a10023          	sb	a0,32(sp)
    8020554e:	850a                	mv	a0,sp
    80205550:	ffffe097          	auipc	ra,0xffffe
    80205554:	fa4080e7          	jalr	-92(ra) # 802034f4 <rust_begin_unwind>
	...

000000008020555a <_ZN4core9panicking5panic17h82a39ff57cd5cc0eE>:
    8020555a:	715d                	add	sp,sp,-80
    8020555c:	e486                	sd	ra,72(sp)
    8020555e:	fc2a                	sd	a0,56(sp)
    80205560:	e0ae                	sd	a1,64(sp)
    80205562:	1828                	add	a0,sp,56
    80205564:	ec2a                	sd	a0,24(sp)
    80205566:	4505                	li	a0,1
    80205568:	f02a                	sd	a0,32(sp)
    8020556a:	e402                	sd	zero,8(sp)

000000008020556c <.Lpcrel_hi462>:
    8020556c:	00003517          	auipc	a0,0x3
    80205570:	43c50513          	add	a0,a0,1084 # 802089a8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.156>
    80205574:	f42a                	sd	a0,40(sp)
    80205576:	f802                	sd	zero,48(sp)
    80205578:	0028                	add	a0,sp,8
    8020557a:	85b2                	mv	a1,a2
    8020557c:	00000097          	auipc	ra,0x0
    80205580:	fb0080e7          	jalr	-80(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080205586 <_ZN4core9panicking18panic_bounds_check17h05a1b05d1577c619E>:
    80205586:	7159                	add	sp,sp,-112
    80205588:	f486                	sd	ra,104(sp)
    8020558a:	e42a                	sd	a0,8(sp)
    8020558c:	e82e                	sd	a1,16(sp)
    8020558e:	0808                	add	a0,sp,16
    80205590:	e4aa                	sd	a0,72(sp)

0000000080205592 <.Lpcrel_hi465>:
    80205592:	00001517          	auipc	a0,0x1
    80205596:	1ee50513          	add	a0,a0,494 # 80206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>
    8020559a:	e8aa                	sd	a0,80(sp)
    8020559c:	002c                	add	a1,sp,8
    8020559e:	ecae                	sd	a1,88(sp)
    802055a0:	f0aa                	sd	a0,96(sp)

00000000802055a2 <.Lpcrel_hi466>:
    802055a2:	00003517          	auipc	a0,0x3
    802055a6:	44650513          	add	a0,a0,1094 # 802089e8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.269>
    802055aa:	f42a                	sd	a0,40(sp)
    802055ac:	4509                	li	a0,2
    802055ae:	f82a                	sd	a0,48(sp)
    802055b0:	ec02                	sd	zero,24(sp)
    802055b2:	00ac                	add	a1,sp,72
    802055b4:	fc2e                	sd	a1,56(sp)
    802055b6:	e0aa                	sd	a0,64(sp)
    802055b8:	0828                	add	a0,sp,24
    802055ba:	85b2                	mv	a1,a2
    802055bc:	00000097          	auipc	ra,0x0
    802055c0:	f70080e7          	jalr	-144(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

00000000802055c6 <_ZN4core9panicking36panic_misaligned_pointer_dereference17h8d2ff04f0586d390E>:
    802055c6:	7115                	add	sp,sp,-224
    802055c8:	ed86                	sd	ra,216(sp)
    802055ca:	e42a                	sd	a0,8(sp)
    802055cc:	e82e                	sd	a1,16(sp)
    802055ce:	0028                	add	a0,sp,8
    802055d0:	e4aa                	sd	a0,72(sp)

00000000802055d2 <.Lpcrel_hi467>:
    802055d2:	00001517          	auipc	a0,0x1
    802055d6:	fbe50513          	add	a0,a0,-66 # 80206590 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E>
    802055da:	e8aa                	sd	a0,80(sp)
    802055dc:	080c                	add	a1,sp,16
    802055de:	ecae                	sd	a1,88(sp)
    802055e0:	f0aa                	sd	a0,96(sp)
    802055e2:	4509                	li	a0,2
    802055e4:	f4aa                	sd	a0,104(sp)
    802055e6:	fcaa                	sd	a0,120(sp)
    802055e8:	4585                	li	a1,1
    802055ea:	02559693          	sll	a3,a1,0x25
    802055ee:	0691                	add	a3,a3,4
    802055f0:	e536                	sd	a3,136(sp)
    802055f2:	470d                	li	a4,3
    802055f4:	08e10823          	sb	a4,144(sp)
    802055f8:	ed02                	sd	zero,152(sp)
    802055fa:	f12a                	sd	a0,160(sp)
    802055fc:	f92a                	sd	a0,176(sp)
    802055fe:	e1b6                	sd	a3,192(sp)
    80205600:	0ce10423          	sb	a4,200(sp)
    80205604:	e9ae                	sd	a1,208(sp)

0000000080205606 <.Lpcrel_hi468>:
    80205606:	00003597          	auipc	a1,0x3
    8020560a:	44258593          	add	a1,a1,1090 # 80208a48 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.272>
    8020560e:	f42e                	sd	a1,40(sp)
    80205610:	f82a                	sd	a0,48(sp)
    80205612:	10ac                	add	a1,sp,104
    80205614:	ec2e                	sd	a1,24(sp)
    80205616:	f02a                	sd	a0,32(sp)
    80205618:	00ac                	add	a1,sp,72
    8020561a:	fc2e                	sd	a1,56(sp)
    8020561c:	e0aa                	sd	a0,64(sp)
    8020561e:	0828                	add	a0,sp,24
    80205620:	85b2                	mv	a1,a2
    80205622:	00000097          	auipc	ra,0x0
    80205626:	f0a080e7          	jalr	-246(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

000000008020562c <_ZN4core6result13unwrap_failed17h8c53b89a3c60dfa4E>:
    8020562c:	7119                	add	sp,sp,-128
    8020562e:	fc86                	sd	ra,120(sp)
    80205630:	e42a                	sd	a0,8(sp)
    80205632:	e82e                	sd	a1,16(sp)
    80205634:	ec32                	sd	a2,24(sp)
    80205636:	f036                	sd	a3,32(sp)
    80205638:	0028                	add	a0,sp,8
    8020563a:	ecaa                	sd	a0,88(sp)

000000008020563c <.Lpcrel_hi487>:
    8020563c:	00001517          	auipc	a0,0x1
    80205640:	16c50513          	add	a0,a0,364 # 802067a8 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf8ad0eea45758417E>
    80205644:	f0aa                	sd	a0,96(sp)
    80205646:	0828                	add	a0,sp,24
    80205648:	f4aa                	sd	a0,104(sp)

000000008020564a <.Lpcrel_hi488>:
    8020564a:	00001517          	auipc	a0,0x1
    8020564e:	15650513          	add	a0,a0,342 # 802067a0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h70355f0e3287a670E>
    80205652:	f8aa                	sd	a0,112(sp)

0000000080205654 <.Lpcrel_hi489>:
    80205654:	00003517          	auipc	a0,0x3
    80205658:	41c50513          	add	a0,a0,1052 # 80208a70 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.287>
    8020565c:	fc2a                	sd	a0,56(sp)
    8020565e:	4509                	li	a0,2
    80205660:	e0aa                	sd	a0,64(sp)
    80205662:	f402                	sd	zero,40(sp)
    80205664:	08ac                	add	a1,sp,88
    80205666:	e4ae                	sd	a1,72(sp)
    80205668:	e8aa                	sd	a0,80(sp)
    8020566a:	1028                	add	a0,sp,40
    8020566c:	85ba                	mv	a1,a4
    8020566e:	00000097          	auipc	ra,0x0
    80205672:	ebe080e7          	jalr	-322(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080205678 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h6c8d2c97bba476a2E>:
    80205678:	7119                	add	sp,sp,-128
    8020567a:	fc86                	sd	ra,120(sp)
    8020567c:	f8a2                	sd	s0,112(sp)
    8020567e:	f4a6                	sd	s1,104(sp)
    80205680:	f0ca                	sd	s2,96(sp)
    80205682:	ecce                	sd	s3,88(sp)
    80205684:	e8d2                	sd	s4,80(sp)
    80205686:	e4d6                	sd	s5,72(sp)
    80205688:	e0da                	sd	s6,64(sp)
    8020568a:	fc5e                	sd	s7,56(sp)
    8020568c:	f862                	sd	s8,48(sp)
    8020568e:	f466                	sd	s9,40(sp)
    80205690:	f06a                	sd	s10,32(sp)
    80205692:	ec6e                	sd	s11,24(sp)
    80205694:	84b2                	mv	s1,a2
    80205696:	8b2e                	mv	s6,a1
    80205698:	4981                	li	s3,0
    8020569a:	4401                	li	s0,0
    8020569c:	4d81                	li	s11,0
    8020569e:	01053a03          	ld	s4,16(a0)
    802056a2:	00053903          	ld	s2,0(a0)
    802056a6:	6508                	ld	a0,8(a0)
    802056a8:	e82a                	sd	a0,16(sp)

00000000802056aa <.Lpcrel_hi492>:
    802056aa:	00003517          	auipc	a0,0x3
    802056ae:	2ff50513          	add	a0,a0,767 # 802089a9 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.156+0x1>
    802056b2:	e42a                	sd	a0,8(sp)
    802056b4:	4bc1                	li	s7,16
    802056b6:	4c29                	li	s8,10
    802056b8:	4c85                	li	s9,1
    802056ba:	a005                	j	802056da <.Lpcrel_hi492+0x30>
    802056bc:	00b60533          	add	a0,a2,a1
    802056c0:	fff54503          	lbu	a0,-1(a0)
    802056c4:	1559                	add	a0,a0,-10
    802056c6:	00153513          	seqz	a0,a0
    802056ca:	00aa0023          	sb	a0,0(s4)
    802056ce:	6542                	ld	a0,16(sp)
    802056d0:	6d14                	ld	a3,24(a0)
    802056d2:	854a                	mv	a0,s2
    802056d4:	9682                	jalr	a3
    802056d6:	89ea                	mv	s3,s10
    802056d8:	ed55                	bnez	a0,80205794 <.Lpcrel_hi492+0xea>
    802056da:	0ffdf513          	zext.b	a0,s11
    802056de:	e94d                	bnez	a0,80205790 <.Lpcrel_hi492+0xe6>
    802056e0:	0284fb63          	bgeu	s1,s0,80205716 <.Lpcrel_hi492+0x6c>
    802056e4:	4d85                	li	s11,1
    802056e6:	8d4e                	mv	s10,s3
    802056e8:	8aa6                	mv	s5,s1
    802056ea:	0a998363          	beq	s3,s1,80205790 <.Lpcrel_hi492+0xe6>
    802056ee:	000a4503          	lbu	a0,0(s4)
    802056f2:	c901                	beqz	a0,80205702 <.Lpcrel_hi492+0x58>
    802056f4:	6542                	ld	a0,16(sp)
    802056f6:	6d14                	ld	a3,24(a0)
    802056f8:	4611                	li	a2,4
    802056fa:	854a                	mv	a0,s2
    802056fc:	65a2                	ld	a1,8(sp)
    802056fe:	9682                	jalr	a3
    80205700:	e951                	bnez	a0,80205794 <.Lpcrel_hi492+0xea>
    80205702:	413a8633          	sub	a2,s5,s3
    80205706:	013b05b3          	add	a1,s6,s3
    8020570a:	fb3a99e3          	bne	s5,s3,802056bc <.Lpcrel_hi492+0x12>
    8020570e:	4501                	li	a0,0
    80205710:	bf6d                	j	802056ca <.Lpcrel_hi492+0x20>
    80205712:	fc84e9e3          	bltu	s1,s0,802056e4 <.Lpcrel_hi492+0x3a>
    80205716:	40848633          	sub	a2,s1,s0
    8020571a:	008b06b3          	add	a3,s6,s0
    8020571e:	03767263          	bgeu	a2,s7,80205742 <.Lpcrel_hi492+0x98>
    80205722:	4581                	li	a1,0
    80205724:	ca05                	beqz	a2,80205754 <.Lpcrel_hi492+0xaa>
    80205726:	00b68533          	add	a0,a3,a1
    8020572a:	00054503          	lbu	a0,0(a0)
    8020572e:	03850763          	beq	a0,s8,8020575c <.Lpcrel_hi492+0xb2>
    80205732:	0585                	add	a1,a1,1
    80205734:	feb619e3          	bne	a2,a1,80205726 <.Lpcrel_hi492+0x7c>
    80205738:	4501                	li	a0,0
    8020573a:	85b2                	mv	a1,a2
    8020573c:	03950363          	beq	a0,s9,80205762 <.Lpcrel_hi492+0xb8>
    80205740:	a091                	j	80205784 <.Lpcrel_hi492+0xda>
    80205742:	4529                	li	a0,10
    80205744:	85b6                	mv	a1,a3
    80205746:	00001097          	auipc	ra,0x1
    8020574a:	a74080e7          	jalr	-1420(ra) # 802061ba <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E>
    8020574e:	01950a63          	beq	a0,s9,80205762 <.Lpcrel_hi492+0xb8>
    80205752:	a80d                	j	80205784 <.Lpcrel_hi492+0xda>
    80205754:	4501                	li	a0,0
    80205756:	01950663          	beq	a0,s9,80205762 <.Lpcrel_hi492+0xb8>
    8020575a:	a02d                	j	80205784 <.Lpcrel_hi492+0xda>
    8020575c:	4505                	li	a0,1
    8020575e:	03951363          	bne	a0,s9,80205784 <.Lpcrel_hi492+0xda>
    80205762:	95a2                	add	a1,a1,s0
    80205764:	00158413          	add	s0,a1,1
    80205768:	fa95f5e3          	bgeu	a1,s1,80205712 <.Lpcrel_hi492+0x68>
    8020576c:	95da                	add	a1,a1,s6
    8020576e:	0005c503          	lbu	a0,0(a1)
    80205772:	fb8510e3          	bne	a0,s8,80205712 <.Lpcrel_hi492+0x68>
    80205776:	4d81                	li	s11,0
    80205778:	8d22                	mv	s10,s0
    8020577a:	8aa2                	mv	s5,s0
    8020577c:	000a4503          	lbu	a0,0(s4)
    80205780:	f935                	bnez	a0,802056f4 <.Lpcrel_hi492+0x4a>
    80205782:	b741                	j	80205702 <.Lpcrel_hi492+0x58>
    80205784:	8426                	mv	s0,s1
    80205786:	4d85                	li	s11,1
    80205788:	8d4e                	mv	s10,s3
    8020578a:	8aa6                	mv	s5,s1
    8020578c:	f69991e3          	bne	s3,s1,802056ee <.Lpcrel_hi492+0x44>
    80205790:	4501                	li	a0,0
    80205792:	a011                	j	80205796 <.Lpcrel_hi492+0xec>
    80205794:	4505                	li	a0,1
    80205796:	70e6                	ld	ra,120(sp)
    80205798:	7446                	ld	s0,112(sp)
    8020579a:	74a6                	ld	s1,104(sp)
    8020579c:	7906                	ld	s2,96(sp)
    8020579e:	69e6                	ld	s3,88(sp)
    802057a0:	6a46                	ld	s4,80(sp)
    802057a2:	6aa6                	ld	s5,72(sp)
    802057a4:	6b06                	ld	s6,64(sp)
    802057a6:	7be2                	ld	s7,56(sp)
    802057a8:	7c42                	ld	s8,48(sp)
    802057aa:	7ca2                	ld	s9,40(sp)
    802057ac:	7d02                	ld	s10,32(sp)
    802057ae:	6de2                	ld	s11,24(sp)
    802057b0:	6109                	add	sp,sp,128
    802057b2:	8082                	ret

00000000802057b4 <_ZN4core3fmt8builders10DebugTuple5field17h0a386522160e6ee8E>:
    802057b4:	7135                	add	sp,sp,-160
    802057b6:	ed06                	sd	ra,152(sp)
    802057b8:	e922                	sd	s0,144(sp)
    802057ba:	e526                	sd	s1,136(sp)
    802057bc:	e14a                	sd	s2,128(sp)
    802057be:	fcce                	sd	s3,120(sp)
    802057c0:	f8d2                	sd	s4,112(sp)
    802057c2:	f4d6                	sd	s5,104(sp)
    802057c4:	842a                	mv	s0,a0
    802057c6:	01054503          	lbu	a0,16(a0)
    802057ca:	c509                	beqz	a0,802057d4 <_ZN4core3fmt8builders10DebugTuple5field17h0a386522160e6ee8E+0x20>
    802057cc:	00043a83          	ld	s5,0(s0)
    802057d0:	4485                	li	s1,1
    802057d2:	a0d5                	j	802058b6 <.Lpcrel_hi510+0xe>
    802057d4:	89b2                	mv	s3,a2
    802057d6:	892e                	mv	s2,a1
    802057d8:	00843a03          	ld	s4,8(s0)
    802057dc:	030a6503          	lwu	a0,48(s4)
    802057e0:	00043a83          	ld	s5,0(s0)
    802057e4:	00457593          	and	a1,a0,4
    802057e8:	e991                	bnez	a1,802057fc <.Lpcrel_hi507+0xa>
    802057ea:	01503633          	snez	a2,s5
    802057ee:	020a8863          	beqz	s5,8020581e <.Lpcrel_hi506>

00000000802057f2 <.Lpcrel_hi507>:
    802057f2:	00003517          	auipc	a0,0x3
    802057f6:	2d050593          	add	a1,a0,720 # 80208ac2 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.292>
    802057fa:	a035                	j	80205826 <.Lpcrel_hi506+0x8>
    802057fc:	040a9663          	bnez	s5,80205848 <.Lpcrel_hi506+0x2a>
    80205800:	008a3583          	ld	a1,8(s4)
    80205804:	000a3503          	ld	a0,0(s4)
    80205808:	6d94                	ld	a3,24(a1)

000000008020580a <.Lpcrel_hi508>:
    8020580a:	00003597          	auipc	a1,0x3
    8020580e:	2ba58593          	add	a1,a1,698 # 80208ac4 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.299>
    80205812:	4609                	li	a2,2
    80205814:	9682                	jalr	a3
    80205816:	c51d                	beqz	a0,80205844 <.Lpcrel_hi506+0x26>
    80205818:	4a81                	li	s5,0
    8020581a:	4485                	li	s1,1
    8020581c:	a869                	j	802058b6 <.Lpcrel_hi510+0xe>

000000008020581e <.Lpcrel_hi506>:
    8020581e:	00003517          	auipc	a0,0x3
    80205822:	2a850593          	add	a1,a0,680 # 80208ac6 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.300>
    80205826:	008a3683          	ld	a3,8(s4)
    8020582a:	000a3503          	ld	a0,0(s4)
    8020582e:	6e94                	ld	a3,24(a3)
    80205830:	0605                	add	a2,a2,1
    80205832:	9682                	jalr	a3
    80205834:	4485                	li	s1,1
    80205836:	e141                	bnez	a0,802058b6 <.Lpcrel_hi510+0xe>
    80205838:	0189b603          	ld	a2,24(s3)
    8020583c:	854a                	mv	a0,s2
    8020583e:	85d2                	mv	a1,s4
    80205840:	9602                	jalr	a2
    80205842:	a88d                	j	802058b4 <.Lpcrel_hi510+0xc>
    80205844:	030a2503          	lw	a0,48(s4)
    80205848:	4485                	li	s1,1
    8020584a:	029103a3          	sb	s1,39(sp)
    8020584e:	000a3583          	ld	a1,0(s4)
    80205852:	008a3603          	ld	a2,8(s4)
    80205856:	e42e                	sd	a1,8(sp)
    80205858:	e832                	sd	a2,16(sp)
    8020585a:	02710593          	add	a1,sp,39
    8020585e:	ec2e                	sd	a1,24(sp)
    80205860:	034a2583          	lw	a1,52(s4)
    80205864:	038a0603          	lb	a2,56(s4)
    80205868:	010a3683          	ld	a3,16(s4)
    8020586c:	018a3703          	ld	a4,24(s4)
    80205870:	020a3783          	ld	a5,32(s4)
    80205874:	028a3803          	ld	a6,40(s4)
    80205878:	ccaa                	sw	a0,88(sp)
    8020587a:	ceae                	sw	a1,92(sp)
    8020587c:	06c10023          	sb	a2,96(sp)
    80205880:	fc36                	sd	a3,56(sp)
    80205882:	e0ba                	sd	a4,64(sp)
    80205884:	e4be                	sd	a5,72(sp)
    80205886:	e8c2                	sd	a6,80(sp)
    80205888:	0028                	add	a0,sp,8
    8020588a:	f42a                	sd	a0,40(sp)
    8020588c:	0189b603          	ld	a2,24(s3)

0000000080205890 <.Lpcrel_hi509>:
    80205890:	00003517          	auipc	a0,0x3
    80205894:	20050513          	add	a0,a0,512 # 80208a90 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.288>
    80205898:	f82a                	sd	a0,48(sp)
    8020589a:	102c                	add	a1,sp,40
    8020589c:	854a                	mv	a0,s2
    8020589e:	9602                	jalr	a2
    802058a0:	e919                	bnez	a0,802058b6 <.Lpcrel_hi510+0xe>
    802058a2:	75c2                	ld	a1,48(sp)
    802058a4:	7522                	ld	a0,40(sp)
    802058a6:	6d94                	ld	a3,24(a1)

00000000802058a8 <.Lpcrel_hi510>:
    802058a8:	00003597          	auipc	a1,0x3
    802058ac:	21858593          	add	a1,a1,536 # 80208ac0 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.291>
    802058b0:	4609                	li	a2,2
    802058b2:	9682                	jalr	a3
    802058b4:	84aa                	mv	s1,a0
    802058b6:	00940823          	sb	s1,16(s0)
    802058ba:	0a85                	add	s5,s5,1
    802058bc:	01543023          	sd	s5,0(s0)
    802058c0:	8522                	mv	a0,s0
    802058c2:	60ea                	ld	ra,152(sp)
    802058c4:	644a                	ld	s0,144(sp)
    802058c6:	64aa                	ld	s1,136(sp)
    802058c8:	690a                	ld	s2,128(sp)
    802058ca:	79e6                	ld	s3,120(sp)
    802058cc:	7a46                	ld	s4,112(sp)
    802058ce:	7aa6                	ld	s5,104(sp)
    802058d0:	610d                	add	sp,sp,160
    802058d2:	8082                	ret

00000000802058d4 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E>:
    802058d4:	1141                	add	sp,sp,-16
    802058d6:	e406                	sd	ra,8(sp)
    802058d8:	0005861b          	sext.w	a2,a1
    802058dc:	08000693          	li	a3,128
    802058e0:	c202                	sw	zero,4(sp)
    802058e2:	00d67663          	bgeu	a2,a3,802058ee <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0x1a>
    802058e6:	00b10223          	sb	a1,4(sp)
    802058ea:	4605                	li	a2,1
    802058ec:	a071                	j	80205978 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0xa4>
    802058ee:	00b5d61b          	srlw	a2,a1,0xb
    802058f2:	ee19                	bnez	a2,80205910 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0x3c>
    802058f4:	0065d613          	srl	a2,a1,0x6
    802058f8:	0c066613          	or	a2,a2,192
    802058fc:	00c10223          	sb	a2,4(sp)
    80205900:	03f5f593          	and	a1,a1,63
    80205904:	08058593          	add	a1,a1,128
    80205908:	00b102a3          	sb	a1,5(sp)
    8020590c:	4609                	li	a2,2
    8020590e:	a0ad                	j	80205978 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0xa4>
    80205910:	0105d61b          	srlw	a2,a1,0x10
    80205914:	e615                	bnez	a2,80205940 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0x6c>
    80205916:	00c5d613          	srl	a2,a1,0xc
    8020591a:	0e066613          	or	a2,a2,224
    8020591e:	00c10223          	sb	a2,4(sp)
    80205922:	03459613          	sll	a2,a1,0x34
    80205926:	9269                	srl	a2,a2,0x3a
    80205928:	08060613          	add	a2,a2,128
    8020592c:	00c102a3          	sb	a2,5(sp)
    80205930:	03f5f593          	and	a1,a1,63
    80205934:	08058593          	add	a1,a1,128
    80205938:	00b10323          	sb	a1,6(sp)
    8020593c:	460d                	li	a2,3
    8020593e:	a82d                	j	80205978 <_ZN4core3fmt5Write10write_char17h91a3ecfce03e3258E+0xa4>
    80205940:	02b59613          	sll	a2,a1,0x2b
    80205944:	9275                	srl	a2,a2,0x3d
    80205946:	0f060613          	add	a2,a2,240
    8020594a:	00c10223          	sb	a2,4(sp)
    8020594e:	02e59613          	sll	a2,a1,0x2e
    80205952:	9269                	srl	a2,a2,0x3a
    80205954:	08060613          	add	a2,a2,128
    80205958:	00c102a3          	sb	a2,5(sp)
    8020595c:	03459613          	sll	a2,a1,0x34
    80205960:	9269                	srl	a2,a2,0x3a
    80205962:	08060613          	add	a2,a2,128
    80205966:	00c10323          	sb	a2,6(sp)
    8020596a:	03f5f593          	and	a1,a1,63
    8020596e:	08058593          	add	a1,a1,128
    80205972:	00b103a3          	sb	a1,7(sp)
    80205976:	4611                	li	a2,4
    80205978:	004c                	add	a1,sp,4
    8020597a:	00000097          	auipc	ra,0x0
    8020597e:	cfe080e7          	jalr	-770(ra) # 80205678 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h6c8d2c97bba476a2E>
    80205982:	60a2                	ld	ra,8(sp)
    80205984:	0141                	add	sp,sp,16
    80205986:	8082                	ret

0000000080205988 <_ZN4core3fmt5Write9write_fmt17hde218c15f565a0b0E>:
    80205988:	7139                	add	sp,sp,-64
    8020598a:	fc06                	sd	ra,56(sp)
    8020598c:	7590                	ld	a2,40(a1)
    8020598e:	7194                	ld	a3,32(a1)
    80205990:	e02a                	sd	a0,0(sp)
    80205992:	f832                	sd	a2,48(sp)
    80205994:	f436                	sd	a3,40(sp)
    80205996:	6d88                	ld	a0,24(a1)
    80205998:	6990                	ld	a2,16(a1)
    8020599a:	6594                	ld	a3,8(a1)
    8020599c:	618c                	ld	a1,0(a1)
    8020599e:	f02a                	sd	a0,32(sp)
    802059a0:	ec32                	sd	a2,24(sp)
    802059a2:	e836                	sd	a3,16(sp)
    802059a4:	e42e                	sd	a1,8(sp)

00000000802059a6 <.Lpcrel_hi660>:
    802059a6:	00003517          	auipc	a0,0x3
    802059aa:	22a50593          	add	a1,a0,554 # 80208bd0 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.330>
    802059ae:	850a                	mv	a0,sp
    802059b0:	0030                	add	a2,sp,8
    802059b2:	00000097          	auipc	ra,0x0
    802059b6:	11a080e7          	jalr	282(ra) # 80205acc <_ZN4core3fmt5write17h725a6c334848b4a3E>
    802059ba:	70e2                	ld	ra,56(sp)
    802059bc:	6121                	add	sp,sp,64
    802059be:	8082                	ret

00000000802059c0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h3f78fdd4ee886d57E>:
    802059c0:	6108                	ld	a0,0(a0)
    802059c2:	00000317          	auipc	t1,0x0
    802059c6:	cb630067          	jr	-842(t1) # 80205678 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h6c8d2c97bba476a2E>

00000000802059ca <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE>:
    802059ca:	1141                	add	sp,sp,-16
    802059cc:	e406                	sd	ra,8(sp)
    802059ce:	6108                	ld	a0,0(a0)
    802059d0:	0005861b          	sext.w	a2,a1
    802059d4:	08000693          	li	a3,128
    802059d8:	c202                	sw	zero,4(sp)
    802059da:	00d67663          	bgeu	a2,a3,802059e6 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0x1c>
    802059de:	00b10223          	sb	a1,4(sp)
    802059e2:	4605                	li	a2,1
    802059e4:	a071                	j	80205a70 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0xa6>
    802059e6:	00b5d61b          	srlw	a2,a1,0xb
    802059ea:	ee19                	bnez	a2,80205a08 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0x3e>
    802059ec:	0065d613          	srl	a2,a1,0x6
    802059f0:	0c066613          	or	a2,a2,192
    802059f4:	00c10223          	sb	a2,4(sp)
    802059f8:	03f5f593          	and	a1,a1,63
    802059fc:	08058593          	add	a1,a1,128
    80205a00:	00b102a3          	sb	a1,5(sp)
    80205a04:	4609                	li	a2,2
    80205a06:	a0ad                	j	80205a70 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0xa6>
    80205a08:	0105d61b          	srlw	a2,a1,0x10
    80205a0c:	e615                	bnez	a2,80205a38 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0x6e>
    80205a0e:	00c5d613          	srl	a2,a1,0xc
    80205a12:	0e066613          	or	a2,a2,224
    80205a16:	00c10223          	sb	a2,4(sp)
    80205a1a:	03459613          	sll	a2,a1,0x34
    80205a1e:	9269                	srl	a2,a2,0x3a
    80205a20:	08060613          	add	a2,a2,128
    80205a24:	00c102a3          	sb	a2,5(sp)
    80205a28:	03f5f593          	and	a1,a1,63
    80205a2c:	08058593          	add	a1,a1,128
    80205a30:	00b10323          	sb	a1,6(sp)
    80205a34:	460d                	li	a2,3
    80205a36:	a82d                	j	80205a70 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h5c648551a511327aE+0xa6>
    80205a38:	02b59613          	sll	a2,a1,0x2b
    80205a3c:	9275                	srl	a2,a2,0x3d
    80205a3e:	0f060613          	add	a2,a2,240
    80205a42:	00c10223          	sb	a2,4(sp)
    80205a46:	02e59613          	sll	a2,a1,0x2e
    80205a4a:	9269                	srl	a2,a2,0x3a
    80205a4c:	08060613          	add	a2,a2,128
    80205a50:	00c102a3          	sb	a2,5(sp)
    80205a54:	03459613          	sll	a2,a1,0x34
    80205a58:	9269                	srl	a2,a2,0x3a
    80205a5a:	08060613          	add	a2,a2,128
    80205a5e:	00c10323          	sb	a2,6(sp)
    80205a62:	03f5f593          	and	a1,a1,63
    80205a66:	08058593          	add	a1,a1,128
    80205a6a:	00b103a3          	sb	a1,7(sp)
    80205a6e:	4611                	li	a2,4
    80205a70:	004c                	add	a1,sp,4
    80205a72:	00000097          	auipc	ra,0x0
    80205a76:	c06080e7          	jalr	-1018(ra) # 80205678 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h6c8d2c97bba476a2E>
    80205a7a:	60a2                	ld	ra,8(sp)
    80205a7c:	0141                	add	sp,sp,16
    80205a7e:	8082                	ret

0000000080205a80 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h00f5b2eb4ea9f5b0E>:
    80205a80:	7139                	add	sp,sp,-64
    80205a82:	fc06                	sd	ra,56(sp)
    80205a84:	7590                	ld	a2,40(a1)
    80205a86:	7194                	ld	a3,32(a1)
    80205a88:	6d98                	ld	a4,24(a1)
    80205a8a:	f832                	sd	a2,48(sp)
    80205a8c:	f436                	sd	a3,40(sp)
    80205a8e:	f03a                	sd	a4,32(sp)
    80205a90:	6990                	ld	a2,16(a1)
    80205a92:	6594                	ld	a3,8(a1)
    80205a94:	618c                	ld	a1,0(a1)
    80205a96:	6108                	ld	a0,0(a0)
    80205a98:	ec32                	sd	a2,24(sp)
    80205a9a:	e836                	sd	a3,16(sp)
    80205a9c:	e42e                	sd	a1,8(sp)
    80205a9e:	e02a                	sd	a0,0(sp)

0000000080205aa0 <.Lpcrel_hi661>:
    80205aa0:	00003517          	auipc	a0,0x3
    80205aa4:	13050593          	add	a1,a0,304 # 80208bd0 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.330>
    80205aa8:	850a                	mv	a0,sp
    80205aaa:	0030                	add	a2,sp,8
    80205aac:	00000097          	auipc	ra,0x0
    80205ab0:	020080e7          	jalr	32(ra) # 80205acc <_ZN4core3fmt5write17h725a6c334848b4a3E>
    80205ab4:	70e2                	ld	ra,56(sp)
    80205ab6:	6121                	add	sp,sp,64
    80205ab8:	8082                	ret

0000000080205aba <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h2dda9a3aab941d66E>:
    80205aba:	6190                	ld	a2,0(a1)
    80205abc:	658c                	ld	a1,8(a1)
    80205abe:	86aa                	mv	a3,a0
    80205ac0:	8532                	mv	a0,a2
    80205ac2:	8636                	mv	a2,a3
    80205ac4:	00000317          	auipc	t1,0x0
    80205ac8:	00830067          	jr	8(t1) # 80205acc <_ZN4core3fmt5write17h725a6c334848b4a3E>

0000000080205acc <_ZN4core3fmt5write17h725a6c334848b4a3E>:
    80205acc:	7119                	add	sp,sp,-128
    80205ace:	fc86                	sd	ra,120(sp)
    80205ad0:	f8a2                	sd	s0,112(sp)
    80205ad2:	f4a6                	sd	s1,104(sp)
    80205ad4:	f0ca                	sd	s2,96(sp)
    80205ad6:	ecce                	sd	s3,88(sp)
    80205ad8:	e8d2                	sd	s4,80(sp)
    80205ada:	e4d6                	sd	s5,72(sp)
    80205adc:	e0da                	sd	s6,64(sp)
    80205ade:	89b2                	mv	s3,a2
    80205ae0:	4605                	li	a2,1
    80205ae2:	1616                	sll	a2,a2,0x25
    80205ae4:	f832                	sd	a2,48(sp)
    80205ae6:	460d                	li	a2,3
    80205ae8:	02c10c23          	sb	a2,56(sp)
    80205aec:	0009b403          	ld	s0,0(s3)
    80205af0:	e802                	sd	zero,16(sp)
    80205af2:	f002                	sd	zero,32(sp)
    80205af4:	e02a                	sd	a0,0(sp)
    80205af6:	e42e                	sd	a1,8(sp)
    80205af8:	c061                	beqz	s0,80205bb8 <.Lpcrel_hi668+0x98>
    80205afa:	0089b503          	ld	a0,8(s3)
    80205afe:	10050763          	beqz	a0,80205c0c <.Lpcrel_hi668+0xec>
    80205b02:	0109b483          	ld	s1,16(s3)
    80205b06:	fff50593          	add	a1,a0,-1
    80205b0a:	058e                	sll	a1,a1,0x3
    80205b0c:	818d                	srl	a1,a1,0x3
    80205b0e:	00158913          	add	s2,a1,1
    80205b12:	04a1                	add	s1,s1,8
    80205b14:	03800593          	li	a1,56
    80205b18:	02b50a33          	mul	s4,a0,a1
    80205b1c:	0461                	add	s0,s0,24
    80205b1e:	4a85                	li	s5,1

0000000080205b20 <.Lpcrel_hi668>:
    80205b20:	00000517          	auipc	a0,0x0
    80205b24:	9f450b13          	add	s6,a0,-1548 # 80205514 <_ZN4core3ops8function6FnOnce9call_once17h53b344e2509276bdE>
    80205b28:	6090                	ld	a2,0(s1)
    80205b2a:	ca01                	beqz	a2,80205b3a <.Lpcrel_hi668+0x1a>
    80205b2c:	66a2                	ld	a3,8(sp)
    80205b2e:	6502                	ld	a0,0(sp)
    80205b30:	ff84b583          	ld	a1,-8(s1)
    80205b34:	6e94                	ld	a3,24(a3)
    80205b36:	9682                	jalr	a3
    80205b38:	ed65                	bnez	a0,80205c30 <.Lpcrel_hi668+0x110>
    80205b3a:	4448                	lw	a0,12(s0)
    80205b3c:	da2a                	sw	a0,52(sp)
    80205b3e:	01040503          	lb	a0,16(s0)
    80205b42:	02a10c23          	sb	a0,56(sp)
    80205b46:	440c                	lw	a1,8(s0)
    80205b48:	0209b503          	ld	a0,32(s3)
    80205b4c:	d82e                	sw	a1,48(sp)
    80205b4e:	ff843603          	ld	a2,-8(s0)
    80205b52:	600c                	ld	a1,0(s0)
    80205b54:	ce01                	beqz	a2,80205b6c <.Lpcrel_hi668+0x4c>
    80205b56:	01561763          	bne	a2,s5,80205b64 <.Lpcrel_hi668+0x44>
    80205b5a:	0592                	sll	a1,a1,0x4
    80205b5c:	95aa                	add	a1,a1,a0
    80205b5e:	6590                	ld	a2,8(a1)
    80205b60:	01660463          	beq	a2,s6,80205b68 <.Lpcrel_hi668+0x48>
    80205b64:	4601                	li	a2,0
    80205b66:	a021                	j	80205b6e <.Lpcrel_hi668+0x4e>
    80205b68:	618c                	ld	a1,0(a1)
    80205b6a:	618c                	ld	a1,0(a1)
    80205b6c:	4605                	li	a2,1
    80205b6e:	e832                	sd	a2,16(sp)
    80205b70:	ec2e                	sd	a1,24(sp)
    80205b72:	fe843603          	ld	a2,-24(s0)
    80205b76:	ff043583          	ld	a1,-16(s0)
    80205b7a:	ce01                	beqz	a2,80205b92 <.Lpcrel_hi668+0x72>
    80205b7c:	01561763          	bne	a2,s5,80205b8a <.Lpcrel_hi668+0x6a>
    80205b80:	0592                	sll	a1,a1,0x4
    80205b82:	95aa                	add	a1,a1,a0
    80205b84:	6590                	ld	a2,8(a1)
    80205b86:	01660463          	beq	a2,s6,80205b8e <.Lpcrel_hi668+0x6e>
    80205b8a:	4601                	li	a2,0
    80205b8c:	a021                	j	80205b94 <.Lpcrel_hi668+0x74>
    80205b8e:	618c                	ld	a1,0(a1)
    80205b90:	618c                	ld	a1,0(a1)
    80205b92:	4605                	li	a2,1
    80205b94:	f032                	sd	a2,32(sp)
    80205b96:	f42e                	sd	a1,40(sp)
    80205b98:	6c0c                	ld	a1,24(s0)
    80205b9a:	0592                	sll	a1,a1,0x4
    80205b9c:	952e                	add	a0,a0,a1
    80205b9e:	6510                	ld	a2,8(a0)
    80205ba0:	6108                	ld	a0,0(a0)
    80205ba2:	858a                	mv	a1,sp
    80205ba4:	9602                	jalr	a2
    80205ba6:	e549                	bnez	a0,80205c30 <.Lpcrel_hi668+0x110>
    80205ba8:	04c1                	add	s1,s1,16
    80205baa:	fc8a0a13          	add	s4,s4,-56
    80205bae:	03840413          	add	s0,s0,56
    80205bb2:	f60a1be3          	bnez	s4,80205b28 <.Lpcrel_hi668+0x8>
    80205bb6:	a0b1                	j	80205c02 <.Lpcrel_hi668+0xe2>
    80205bb8:	0289ba03          	ld	s4,40(s3)
    80205bbc:	040a0863          	beqz	s4,80205c0c <.Lpcrel_hi668+0xec>
    80205bc0:	0209b483          	ld	s1,32(s3)
    80205bc4:	0109b403          	ld	s0,16(s3)
    80205bc8:	fffa0513          	add	a0,s4,-1
    80205bcc:	0512                	sll	a0,a0,0x4
    80205bce:	8111                	srl	a0,a0,0x4
    80205bd0:	00150913          	add	s2,a0,1
    80205bd4:	0421                	add	s0,s0,8
    80205bd6:	0a12                	sll	s4,s4,0x4
    80205bd8:	04a1                	add	s1,s1,8
    80205bda:	6010                	ld	a2,0(s0)
    80205bdc:	ca01                	beqz	a2,80205bec <.Lpcrel_hi668+0xcc>
    80205bde:	66a2                	ld	a3,8(sp)
    80205be0:	6502                	ld	a0,0(sp)
    80205be2:	ff843583          	ld	a1,-8(s0)
    80205be6:	6e94                	ld	a3,24(a3)
    80205be8:	9682                	jalr	a3
    80205bea:	e139                	bnez	a0,80205c30 <.Lpcrel_hi668+0x110>
    80205bec:	6090                	ld	a2,0(s1)
    80205bee:	ff84b503          	ld	a0,-8(s1)
    80205bf2:	858a                	mv	a1,sp
    80205bf4:	9602                	jalr	a2
    80205bf6:	ed0d                	bnez	a0,80205c30 <.Lpcrel_hi668+0x110>
    80205bf8:	0441                	add	s0,s0,16
    80205bfa:	1a41                	add	s4,s4,-16
    80205bfc:	04c1                	add	s1,s1,16
    80205bfe:	fc0a1ee3          	bnez	s4,80205bda <.Lpcrel_hi668+0xba>
    80205c02:	0189b503          	ld	a0,24(s3)
    80205c06:	00a96863          	bltu	s2,a0,80205c16 <.Lpcrel_hi668+0xf6>
    80205c0a:	a02d                	j	80205c34 <.Lpcrel_hi668+0x114>
    80205c0c:	4901                	li	s2,0
    80205c0e:	0189b503          	ld	a0,24(s3)
    80205c12:	02a97163          	bgeu	s2,a0,80205c34 <.Lpcrel_hi668+0x114>
    80205c16:	0109b503          	ld	a0,16(s3)
    80205c1a:	0912                	sll	s2,s2,0x4
    80205c1c:	992a                	add	s2,s2,a0
    80205c1e:	66a2                	ld	a3,8(sp)
    80205c20:	6502                	ld	a0,0(sp)
    80205c22:	00093583          	ld	a1,0(s2)
    80205c26:	00893603          	ld	a2,8(s2)
    80205c2a:	6e94                	ld	a3,24(a3)
    80205c2c:	9682                	jalr	a3
    80205c2e:	c119                	beqz	a0,80205c34 <.Lpcrel_hi668+0x114>
    80205c30:	4505                	li	a0,1
    80205c32:	a011                	j	80205c36 <.Lpcrel_hi668+0x116>
    80205c34:	4501                	li	a0,0
    80205c36:	70e6                	ld	ra,120(sp)
    80205c38:	7446                	ld	s0,112(sp)
    80205c3a:	74a6                	ld	s1,104(sp)
    80205c3c:	7906                	ld	s2,96(sp)
    80205c3e:	69e6                	ld	s3,88(sp)
    80205c40:	6a46                	ld	s4,80(sp)
    80205c42:	6aa6                	ld	s5,72(sp)
    80205c44:	6b06                	ld	s6,64(sp)
    80205c46:	6109                	add	sp,sp,128
    80205c48:	8082                	ret

0000000080205c4a <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE>:
    80205c4a:	7159                	add	sp,sp,-112
    80205c4c:	f486                	sd	ra,104(sp)
    80205c4e:	f0a2                	sd	s0,96(sp)
    80205c50:	eca6                	sd	s1,88(sp)
    80205c52:	e8ca                	sd	s2,80(sp)
    80205c54:	e4ce                	sd	s3,72(sp)
    80205c56:	e0d2                	sd	s4,64(sp)
    80205c58:	fc56                	sd	s5,56(sp)
    80205c5a:	f85a                	sd	s6,48(sp)
    80205c5c:	f45e                	sd	s7,40(sp)
    80205c5e:	f062                	sd	s8,32(sp)
    80205c60:	ec66                	sd	s9,24(sp)
    80205c62:	e86a                	sd	s10,16(sp)
    80205c64:	e46e                	sd	s11,8(sp)
    80205c66:	89be                	mv	s3,a5
    80205c68:	893a                	mv	s2,a4
    80205c6a:	8b36                	mv	s6,a3
    80205c6c:	8a32                	mv	s4,a2
    80205c6e:	8c2a                	mv	s8,a0
    80205c70:	c1b9                	beqz	a1,80205cb6 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x6c>
    80205c72:	030c6403          	lwu	s0,48(s8)
    80205c76:	00147c93          	and	s9,s0,1
    80205c7a:	00110ab7          	lui	s5,0x110
    80205c7e:	000c8463          	beqz	s9,80205c86 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x3c>
    80205c82:	02b00a93          	li	s5,43
    80205c86:	9cce                	add	s9,s9,s3
    80205c88:	00447513          	and	a0,s0,4
    80205c8c:	cd15                	beqz	a0,80205cc8 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x7e>
    80205c8e:	02000513          	li	a0,32
    80205c92:	04ab7063          	bgeu	s6,a0,80205cd2 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x88>
    80205c96:	4501                	li	a0,0
    80205c98:	040b0363          	beqz	s6,80205cde <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x94>
    80205c9c:	85da                	mv	a1,s6
    80205c9e:	8652                	mv	a2,s4
    80205ca0:	00060683          	lb	a3,0(a2)
    80205ca4:	0605                	add	a2,a2,1
    80205ca6:	fc06a693          	slti	a3,a3,-64
    80205caa:	0016c693          	xor	a3,a3,1
    80205cae:	15fd                	add	a1,a1,-1
    80205cb0:	9536                	add	a0,a0,a3
    80205cb2:	f5fd                	bnez	a1,80205ca0 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x56>
    80205cb4:	a02d                	j	80205cde <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x94>
    80205cb6:	030c2403          	lw	s0,48(s8)
    80205cba:	00198c93          	add	s9,s3,1
    80205cbe:	02d00a93          	li	s5,45
    80205cc2:	00447513          	and	a0,s0,4
    80205cc6:	f561                	bnez	a0,80205c8e <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x44>
    80205cc8:	4a01                	li	s4,0
    80205cca:	010c3503          	ld	a0,16(s8)
    80205cce:	ed01                	bnez	a0,80205ce6 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x9c>
    80205cd0:	a83d                	j	80205d0e <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xc4>
    80205cd2:	8552                	mv	a0,s4
    80205cd4:	85da                	mv	a1,s6
    80205cd6:	00000097          	auipc	ra,0x0
    80205cda:	6aa080e7          	jalr	1706(ra) # 80206380 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E>
    80205cde:	9caa                	add	s9,s9,a0
    80205ce0:	010c3503          	ld	a0,16(s8)
    80205ce4:	c50d                	beqz	a0,80205d0e <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xc4>
    80205ce6:	018c3d03          	ld	s10,24(s8)
    80205cea:	03acf263          	bgeu	s9,s10,80205d0e <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xc4>
    80205cee:	8821                	and	s0,s0,8
    80205cf0:	e049                	bnez	s0,80205d72 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x128>
    80205cf2:	038c4583          	lbu	a1,56(s8)
    80205cf6:	450d                	li	a0,3
    80205cf8:	00a59363          	bne	a1,a0,80205cfe <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xb4>
    80205cfc:	4585                	li	a1,1
    80205cfe:	419d0533          	sub	a0,s10,s9
    80205d02:	cddd                	beqz	a1,80205dc0 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x176>
    80205d04:	4605                	li	a2,1
    80205d06:	0cc59063          	bne	a1,a2,80205dc6 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x17c>
    80205d0a:	4d01                	li	s10,0
    80205d0c:	a0d1                	j	80205dd0 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x186>
    80205d0e:	000c3403          	ld	s0,0(s8)
    80205d12:	008c3483          	ld	s1,8(s8)
    80205d16:	8522                	mv	a0,s0
    80205d18:	85a6                	mv	a1,s1
    80205d1a:	8656                	mv	a2,s5
    80205d1c:	86d2                	mv	a3,s4
    80205d1e:	875a                	mv	a4,s6
    80205d20:	00000097          	auipc	ra,0x0
    80205d24:	144080e7          	jalr	324(ra) # 80205e64 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E>
    80205d28:	4b85                	li	s7,1
    80205d2a:	c10d                	beqz	a0,80205d4c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x102>
    80205d2c:	855e                	mv	a0,s7
    80205d2e:	70a6                	ld	ra,104(sp)
    80205d30:	7406                	ld	s0,96(sp)
    80205d32:	64e6                	ld	s1,88(sp)
    80205d34:	6946                	ld	s2,80(sp)
    80205d36:	69a6                	ld	s3,72(sp)
    80205d38:	6a06                	ld	s4,64(sp)
    80205d3a:	7ae2                	ld	s5,56(sp)
    80205d3c:	7b42                	ld	s6,48(sp)
    80205d3e:	7ba2                	ld	s7,40(sp)
    80205d40:	7c02                	ld	s8,32(sp)
    80205d42:	6ce2                	ld	s9,24(sp)
    80205d44:	6d42                	ld	s10,16(sp)
    80205d46:	6da2                	ld	s11,8(sp)
    80205d48:	6165                	add	sp,sp,112
    80205d4a:	8082                	ret
    80205d4c:	6c9c                	ld	a5,24(s1)
    80205d4e:	8522                	mv	a0,s0
    80205d50:	85ca                	mv	a1,s2
    80205d52:	864e                	mv	a2,s3
    80205d54:	70a6                	ld	ra,104(sp)
    80205d56:	7406                	ld	s0,96(sp)
    80205d58:	64e6                	ld	s1,88(sp)
    80205d5a:	6946                	ld	s2,80(sp)
    80205d5c:	69a6                	ld	s3,72(sp)
    80205d5e:	6a06                	ld	s4,64(sp)
    80205d60:	7ae2                	ld	s5,56(sp)
    80205d62:	7b42                	ld	s6,48(sp)
    80205d64:	7ba2                	ld	s7,40(sp)
    80205d66:	7c02                	ld	s8,32(sp)
    80205d68:	6ce2                	ld	s9,24(sp)
    80205d6a:	6d42                	ld	s10,16(sp)
    80205d6c:	6da2                	ld	s11,8(sp)
    80205d6e:	6165                	add	sp,sp,112
    80205d70:	8782                	jr	a5
    80205d72:	034c2403          	lw	s0,52(s8)
    80205d76:	03000513          	li	a0,48
    80205d7a:	038c4583          	lbu	a1,56(s8)
    80205d7e:	e02e                	sd	a1,0(sp)
    80205d80:	000c3d83          	ld	s11,0(s8)
    80205d84:	008c3483          	ld	s1,8(s8)
    80205d88:	02ac2a23          	sw	a0,52(s8)
    80205d8c:	4b85                	li	s7,1
    80205d8e:	037c0c23          	sb	s7,56(s8)
    80205d92:	856e                	mv	a0,s11
    80205d94:	85a6                	mv	a1,s1
    80205d96:	8656                	mv	a2,s5
    80205d98:	86d2                	mv	a3,s4
    80205d9a:	875a                	mv	a4,s6
    80205d9c:	00000097          	auipc	ra,0x0
    80205da0:	0c8080e7          	jalr	200(ra) # 80205e64 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E>
    80205da4:	f541                	bnez	a0,80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205da6:	8a22                	mv	s4,s0
    80205da8:	419d0433          	sub	s0,s10,s9
    80205dac:	0405                	add	s0,s0,1
    80205dae:	147d                	add	s0,s0,-1
    80205db0:	c841                	beqz	s0,80205e40 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x1f6>
    80205db2:	7090                	ld	a2,32(s1)
    80205db4:	03000593          	li	a1,48
    80205db8:	856e                	mv	a0,s11
    80205dba:	9602                	jalr	a2
    80205dbc:	d96d                	beqz	a0,80205dae <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x164>
    80205dbe:	b7bd                	j	80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205dc0:	8d2a                	mv	s10,a0
    80205dc2:	852e                	mv	a0,a1
    80205dc4:	a031                	j	80205dd0 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x186>
    80205dc6:	00150593          	add	a1,a0,1
    80205dca:	8105                	srl	a0,a0,0x1
    80205dcc:	0015dd13          	srl	s10,a1,0x1
    80205dd0:	000c3c83          	ld	s9,0(s8)
    80205dd4:	008c3d83          	ld	s11,8(s8)
    80205dd8:	034c2483          	lw	s1,52(s8)
    80205ddc:	00150413          	add	s0,a0,1
    80205de0:	147d                	add	s0,s0,-1
    80205de2:	c809                	beqz	s0,80205df4 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x1aa>
    80205de4:	020db603          	ld	a2,32(s11)
    80205de8:	8566                	mv	a0,s9
    80205dea:	85a6                	mv	a1,s1
    80205dec:	9602                	jalr	a2
    80205dee:	d96d                	beqz	a0,80205de0 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x196>
    80205df0:	4b85                	li	s7,1
    80205df2:	bf2d                	j	80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205df4:	00110537          	lui	a0,0x110
    80205df8:	4b85                	li	s7,1
    80205dfa:	f2a489e3          	beq	s1,a0,80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205dfe:	8566                	mv	a0,s9
    80205e00:	85ee                	mv	a1,s11
    80205e02:	8656                	mv	a2,s5
    80205e04:	86d2                	mv	a3,s4
    80205e06:	875a                	mv	a4,s6
    80205e08:	00000097          	auipc	ra,0x0
    80205e0c:	05c080e7          	jalr	92(ra) # 80205e64 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E>
    80205e10:	fd11                	bnez	a0,80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205e12:	018db683          	ld	a3,24(s11)
    80205e16:	8566                	mv	a0,s9
    80205e18:	85ca                	mv	a1,s2
    80205e1a:	864e                	mv	a2,s3
    80205e1c:	9682                	jalr	a3
    80205e1e:	f519                	bnez	a0,80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205e20:	41a009b3          	neg	s3,s10
    80205e24:	5a7d                	li	s4,-1
    80205e26:	597d                	li	s2,-1
    80205e28:	01298533          	add	a0,s3,s2
    80205e2c:	03450863          	beq	a0,s4,80205e5c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x212>
    80205e30:	020db603          	ld	a2,32(s11)
    80205e34:	8566                	mv	a0,s9
    80205e36:	85a6                	mv	a1,s1
    80205e38:	9602                	jalr	a2
    80205e3a:	0905                	add	s2,s2,1
    80205e3c:	d575                	beqz	a0,80205e28 <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x1de>
    80205e3e:	a005                	j	80205e5e <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0x214>
    80205e40:	6c94                	ld	a3,24(s1)
    80205e42:	856e                	mv	a0,s11
    80205e44:	85ca                	mv	a1,s2
    80205e46:	864e                	mv	a2,s3
    80205e48:	9682                	jalr	a3
    80205e4a:	ee0511e3          	bnez	a0,80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205e4e:	4b81                	li	s7,0
    80205e50:	034c2a23          	sw	s4,52(s8)
    80205e54:	6502                	ld	a0,0(sp)
    80205e56:	02ac0c23          	sb	a0,56(s8)
    80205e5a:	bdc9                	j	80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>
    80205e5c:	896a                	mv	s2,s10
    80205e5e:	01a93bb3          	sltu	s7,s2,s10
    80205e62:	b5e9                	j	80205d2c <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE+0xe2>

0000000080205e64 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E>:
    80205e64:	7179                	add	sp,sp,-48
    80205e66:	f406                	sd	ra,40(sp)
    80205e68:	f022                	sd	s0,32(sp)
    80205e6a:	ec26                	sd	s1,24(sp)
    80205e6c:	e84a                	sd	s2,16(sp)
    80205e6e:	e44e                	sd	s3,8(sp)
    80205e70:	0006079b          	sext.w	a5,a2
    80205e74:	00110837          	lui	a6,0x110
    80205e78:	893a                	mv	s2,a4
    80205e7a:	84b6                	mv	s1,a3
    80205e7c:	842e                	mv	s0,a1
    80205e7e:	89aa                	mv	s3,a0
    80205e80:	01078963          	beq	a5,a6,80205e92 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E+0x2e>
    80205e84:	7014                	ld	a3,32(s0)
    80205e86:	854e                	mv	a0,s3
    80205e88:	85b2                	mv	a1,a2
    80205e8a:	9682                	jalr	a3
    80205e8c:	85aa                	mv	a1,a0
    80205e8e:	4505                	li	a0,1
    80205e90:	ed91                	bnez	a1,80205eac <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E+0x48>
    80205e92:	cc81                	beqz	s1,80205eaa <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2766e09316cdec71E+0x46>
    80205e94:	6c1c                	ld	a5,24(s0)
    80205e96:	854e                	mv	a0,s3
    80205e98:	85a6                	mv	a1,s1
    80205e9a:	864a                	mv	a2,s2
    80205e9c:	70a2                	ld	ra,40(sp)
    80205e9e:	7402                	ld	s0,32(sp)
    80205ea0:	64e2                	ld	s1,24(sp)
    80205ea2:	6942                	ld	s2,16(sp)
    80205ea4:	69a2                	ld	s3,8(sp)
    80205ea6:	6145                	add	sp,sp,48
    80205ea8:	8782                	jr	a5
    80205eaa:	4501                	li	a0,0
    80205eac:	70a2                	ld	ra,40(sp)
    80205eae:	7402                	ld	s0,32(sp)
    80205eb0:	64e2                	ld	s1,24(sp)
    80205eb2:	6942                	ld	s2,16(sp)
    80205eb4:	69a2                	ld	s3,8(sp)
    80205eb6:	6145                	add	sp,sp,48
    80205eb8:	8082                	ret

0000000080205eba <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E>:
    80205eba:	715d                	add	sp,sp,-80
    80205ebc:	e486                	sd	ra,72(sp)
    80205ebe:	e0a2                	sd	s0,64(sp)
    80205ec0:	fc26                	sd	s1,56(sp)
    80205ec2:	f84a                	sd	s2,48(sp)
    80205ec4:	f44e                	sd	s3,40(sp)
    80205ec6:	f052                	sd	s4,32(sp)
    80205ec8:	ec56                	sd	s5,24(sp)
    80205eca:	e85a                	sd	s6,16(sp)
    80205ecc:	e45e                	sd	s7,8(sp)
    80205ece:	8a2a                	mv	s4,a0
    80205ed0:	01053283          	ld	t0,16(a0) # 110010 <.Lline_table_start0+0xca7c7>
    80205ed4:	7108                	ld	a0,32(a0)
    80205ed6:	00a2e6b3          	or	a3,t0,a0
    80205eda:	89b2                	mv	s3,a2
    80205edc:	892e                	mv	s2,a1
    80205ede:	16068a63          	beqz	a3,80206052 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x198>
    80205ee2:	10050763          	beqz	a0,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205ee6:	028a3703          	ld	a4,40(s4)
    80205eea:	4501                	li	a0,0
    80205eec:	013906b3          	add	a3,s2,s3
    80205ef0:	0705                	add	a4,a4,1
    80205ef2:	00110337          	lui	t1,0x110
    80205ef6:	0df00893          	li	a7,223
    80205efa:	0f000813          	li	a6,240
    80205efe:	864a                	mv	a2,s2
    80205f00:	a801                	j	80205f10 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x56>
    80205f02:	00160593          	add	a1,a2,1
    80205f06:	8d11                	sub	a0,a0,a2
    80205f08:	952e                	add	a0,a0,a1
    80205f0a:	862e                	mv	a2,a1
    80205f0c:	0e640263          	beq	s0,t1,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205f10:	177d                	add	a4,a4,-1
    80205f12:	c725                	beqz	a4,80205f7a <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0xc0>
    80205f14:	0cd60e63          	beq	a2,a3,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205f18:	00060583          	lb	a1,0(a2)
    80205f1c:	0ff5f413          	zext.b	s0,a1
    80205f20:	fe05d1e3          	bgez	a1,80205f02 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x48>
    80205f24:	00164583          	lbu	a1,1(a2)
    80205f28:	01f47493          	and	s1,s0,31
    80205f2c:	03f5f793          	and	a5,a1,63
    80205f30:	0288f963          	bgeu	a7,s0,80205f62 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0xa8>
    80205f34:	00264583          	lbu	a1,2(a2)
    80205f38:	079a                	sll	a5,a5,0x6
    80205f3a:	03f5f593          	and	a1,a1,63
    80205f3e:	8fcd                	or	a5,a5,a1
    80205f40:	03046763          	bltu	s0,a6,80205f6e <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0xb4>
    80205f44:	00364583          	lbu	a1,3(a2)
    80205f48:	14f6                	sll	s1,s1,0x3d
    80205f4a:	90ad                	srl	s1,s1,0x2b
    80205f4c:	079a                	sll	a5,a5,0x6
    80205f4e:	03f5f593          	and	a1,a1,63
    80205f52:	8ddd                	or	a1,a1,a5
    80205f54:	0095e433          	or	s0,a1,s1
    80205f58:	08640c63          	beq	s0,t1,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205f5c:	00460593          	add	a1,a2,4
    80205f60:	b75d                	j	80205f06 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x4c>
    80205f62:	00260593          	add	a1,a2,2
    80205f66:	00649413          	sll	s0,s1,0x6
    80205f6a:	8c5d                	or	s0,s0,a5
    80205f6c:	bf69                	j	80205f06 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x4c>
    80205f6e:	00360593          	add	a1,a2,3
    80205f72:	00c49413          	sll	s0,s1,0xc
    80205f76:	8c5d                	or	s0,s0,a5
    80205f78:	b779                	j	80205f06 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x4c>
    80205f7a:	06d60b63          	beq	a2,a3,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205f7e:	00060583          	lb	a1,0(a2)
    80205f82:	0405d363          	bgez	a1,80205fc8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x10e>
    80205f86:	0ff5f593          	zext.b	a1,a1
    80205f8a:	0e000693          	li	a3,224
    80205f8e:	02d5ed63          	bltu	a1,a3,80205fc8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x10e>
    80205f92:	0f000693          	li	a3,240
    80205f96:	02d5e963          	bltu	a1,a3,80205fc8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x10e>
    80205f9a:	00164683          	lbu	a3,1(a2)
    80205f9e:	00264703          	lbu	a4,2(a2)
    80205fa2:	03f6f693          	and	a3,a3,63
    80205fa6:	03f77713          	and	a4,a4,63
    80205faa:	00364603          	lbu	a2,3(a2)
    80205fae:	15f6                	sll	a1,a1,0x3d
    80205fb0:	91ad                	srl	a1,a1,0x2b
    80205fb2:	06b2                	sll	a3,a3,0xc
    80205fb4:	071a                	sll	a4,a4,0x6
    80205fb6:	8ed9                	or	a3,a3,a4
    80205fb8:	03f67613          	and	a2,a2,63
    80205fbc:	8e55                	or	a2,a2,a3
    80205fbe:	8dd1                	or	a1,a1,a2
    80205fc0:	00110637          	lui	a2,0x110
    80205fc4:	02c58663          	beq	a1,a2,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205fc8:	c105                	beqz	a0,80205fe8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x12e>
    80205fca:	01357d63          	bgeu	a0,s3,80205fe4 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x12a>
    80205fce:	00a905b3          	add	a1,s2,a0
    80205fd2:	00058583          	lb	a1,0(a1)
    80205fd6:	fc000613          	li	a2,-64
    80205fda:	00c5d763          	bge	a1,a2,80205fe8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x12e>
    80205fde:	4581                	li	a1,0
    80205fe0:	e591                	bnez	a1,80205fec <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x132>
    80205fe2:	a039                	j	80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205fe4:	ff351de3          	bne	a0,s3,80205fde <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x124>
    80205fe8:	85ca                	mv	a1,s2
    80205fea:	c199                	beqz	a1,80205ff0 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x136>
    80205fec:	89aa                	mv	s3,a0
    80205fee:	892e                	mv	s2,a1
    80205ff0:	06028163          	beqz	t0,80206052 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x198>
    80205ff4:	018a3403          	ld	s0,24(s4)
    80205ff8:	02000513          	li	a0,32
    80205ffc:	04a9f363          	bgeu	s3,a0,80206042 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x188>
    80206000:	4501                	li	a0,0
    80206002:	00098e63          	beqz	s3,8020601e <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x164>
    80206006:	85ce                	mv	a1,s3
    80206008:	864a                	mv	a2,s2
    8020600a:	00060683          	lb	a3,0(a2) # 110000 <.Lline_table_start0+0xca7b7>
    8020600e:	0605                	add	a2,a2,1
    80206010:	fc06a693          	slti	a3,a3,-64
    80206014:	0016c693          	xor	a3,a3,1
    80206018:	15fd                	add	a1,a1,-1
    8020601a:	9536                	add	a0,a0,a3
    8020601c:	f5fd                	bnez	a1,8020600a <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x150>
    8020601e:	02857a63          	bgeu	a0,s0,80206052 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x198>
    80206022:	038a4583          	lbu	a1,56(s4)
    80206026:	ffd58613          	add	a2,a1,-3
    8020602a:	00163613          	seqz	a2,a2
    8020602e:	167d                	add	a2,a2,-1
    80206030:	8df1                	and	a1,a1,a2
    80206032:	40a40533          	sub	a0,s0,a0
    80206036:	c1a1                	beqz	a1,80206076 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1bc>
    80206038:	4605                	li	a2,1
    8020603a:	04c59163          	bne	a1,a2,8020607c <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1c2>
    8020603e:	4a81                	li	s5,0
    80206040:	a099                	j	80206086 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1cc>
    80206042:	854a                	mv	a0,s2
    80206044:	85ce                	mv	a1,s3
    80206046:	00000097          	auipc	ra,0x0
    8020604a:	33a080e7          	jalr	826(ra) # 80206380 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E>
    8020604e:	fc856ae3          	bltu	a0,s0,80206022 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x168>
    80206052:	008a3583          	ld	a1,8(s4)
    80206056:	000a3503          	ld	a0,0(s4)
    8020605a:	6d9c                	ld	a5,24(a1)
    8020605c:	85ca                	mv	a1,s2
    8020605e:	864e                	mv	a2,s3
    80206060:	60a6                	ld	ra,72(sp)
    80206062:	6406                	ld	s0,64(sp)
    80206064:	74e2                	ld	s1,56(sp)
    80206066:	7942                	ld	s2,48(sp)
    80206068:	79a2                	ld	s3,40(sp)
    8020606a:	7a02                	ld	s4,32(sp)
    8020606c:	6ae2                	ld	s5,24(sp)
    8020606e:	6b42                	ld	s6,16(sp)
    80206070:	6ba2                	ld	s7,8(sp)
    80206072:	6161                	add	sp,sp,80
    80206074:	8782                	jr	a5
    80206076:	8aaa                	mv	s5,a0
    80206078:	852e                	mv	a0,a1
    8020607a:	a031                	j	80206086 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1cc>
    8020607c:	00150593          	add	a1,a0,1
    80206080:	8105                	srl	a0,a0,0x1
    80206082:	0015da93          	srl	s5,a1,0x1
    80206086:	000a3b03          	ld	s6,0(s4)
    8020608a:	008a3b83          	ld	s7,8(s4)
    8020608e:	034a2483          	lw	s1,52(s4)
    80206092:	00150413          	add	s0,a0,1
    80206096:	147d                	add	s0,s0,-1
    80206098:	c809                	beqz	s0,802060aa <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1f0>
    8020609a:	020bb603          	ld	a2,32(s7)
    8020609e:	855a                	mv	a0,s6
    802060a0:	85a6                	mv	a1,s1
    802060a2:	9602                	jalr	a2
    802060a4:	d96d                	beqz	a0,80206096 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x1dc>
    802060a6:	4a05                	li	s4,1
    802060a8:	a081                	j	802060e8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x22e>
    802060aa:	00110537          	lui	a0,0x110
    802060ae:	4a05                	li	s4,1
    802060b0:	02a48c63          	beq	s1,a0,802060e8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x22e>
    802060b4:	018bb683          	ld	a3,24(s7)
    802060b8:	855a                	mv	a0,s6
    802060ba:	85ca                	mv	a1,s2
    802060bc:	864e                	mv	a2,s3
    802060be:	9682                	jalr	a3
    802060c0:	e505                	bnez	a0,802060e8 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x22e>
    802060c2:	41500933          	neg	s2,s5
    802060c6:	59fd                	li	s3,-1
    802060c8:	547d                	li	s0,-1
    802060ca:	00890533          	add	a0,s2,s0
    802060ce:	01350a63          	beq	a0,s3,802060e2 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x228>
    802060d2:	020bb603          	ld	a2,32(s7)
    802060d6:	855a                	mv	a0,s6
    802060d8:	85a6                	mv	a1,s1
    802060da:	9602                	jalr	a2
    802060dc:	0405                	add	s0,s0,1
    802060de:	d575                	beqz	a0,802060ca <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x210>
    802060e0:	a011                	j	802060e4 <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E+0x22a>
    802060e2:	8456                	mv	s0,s5
    802060e4:	01543a33          	sltu	s4,s0,s5
    802060e8:	8552                	mv	a0,s4
    802060ea:	60a6                	ld	ra,72(sp)
    802060ec:	6406                	ld	s0,64(sp)
    802060ee:	74e2                	ld	s1,56(sp)
    802060f0:	7942                	ld	s2,48(sp)
    802060f2:	79a2                	ld	s3,40(sp)
    802060f4:	7a02                	ld	s4,32(sp)
    802060f6:	6ae2                	ld	s5,24(sp)
    802060f8:	6b42                	ld	s6,16(sp)
    802060fa:	6ba2                	ld	s7,8(sp)
    802060fc:	6161                	add	sp,sp,80
    802060fe:	8082                	ret

0000000080206100 <_ZN4core3fmt9Formatter9write_str17h20c02ed242b40bdfE>:
    80206100:	6514                	ld	a3,8(a0)
    80206102:	6108                	ld	a0,0(a0)
    80206104:	6e9c                	ld	a5,24(a3)
    80206106:	8782                	jr	a5

0000000080206108 <_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h44ef5ce4a1577e92E>:
    80206108:	7139                	add	sp,sp,-64
    8020610a:	fc06                	sd	ra,56(sp)
    8020610c:	f822                	sd	s0,48(sp)
    8020610e:	f426                	sd	s1,40(sp)
    80206110:	f04a                	sd	s2,32(sp)
    80206112:	ec4e                	sd	s3,24(sp)
    80206114:	842a                	mv	s0,a0
    80206116:	651c                	ld	a5,8(a0)
    80206118:	6108                	ld	a0,0(a0)
    8020611a:	6f9c                	ld	a5,24(a5)
    8020611c:	893a                	mv	s2,a4
    8020611e:	89b6                	mv	s3,a3
    80206120:	84b2                	mv	s1,a2
    80206122:	9782                	jalr	a5
    80206124:	0014b593          	seqz	a1,s1
    80206128:	e422                	sd	s0,8(sp)
    8020612a:	00a10823          	sb	a0,16(sp)
    8020612e:	e002                	sd	zero,0(sp)
    80206130:	00b108a3          	sb	a1,17(sp)
    80206134:	850a                	mv	a0,sp
    80206136:	85ce                	mv	a1,s3
    80206138:	864a                	mv	a2,s2
    8020613a:	fffff097          	auipc	ra,0xfffff
    8020613e:	67a080e7          	jalr	1658(ra) # 802057b4 <_ZN4core3fmt8builders10DebugTuple5field17h0a386522160e6ee8E>
    80206142:	6502                	ld	a0,0(sp)
    80206144:	01014583          	lbu	a1,16(sp)
    80206148:	c539                	beqz	a0,80206196 <.Lpcrel_hi688+0x10>
    8020614a:	4405                	li	s0,1
    8020614c:	e5b9                	bnez	a1,8020619a <.Lpcrel_hi688+0x14>
    8020614e:	01114583          	lbu	a1,17(sp)
    80206152:	157d                	add	a0,a0,-1 # 10ffff <.Lline_table_start0+0xca7b6>
    80206154:	00153513          	seqz	a0,a0
    80206158:	64a2                	ld	s1,8(sp)
    8020615a:	00b035b3          	snez	a1,a1
    8020615e:	8d6d                	and	a0,a0,a1
    80206160:	c105                	beqz	a0,80206180 <.Lpcrel_hi689+0x10>
    80206162:	0304c503          	lbu	a0,48(s1)
    80206166:	8911                	and	a0,a0,4
    80206168:	ed01                	bnez	a0,80206180 <.Lpcrel_hi689+0x10>
    8020616a:	648c                	ld	a1,8(s1)
    8020616c:	6088                	ld	a0,0(s1)
    8020616e:	6d94                	ld	a3,24(a1)

0000000080206170 <.Lpcrel_hi689>:
    80206170:	00003597          	auipc	a1,0x3
    80206174:	95758593          	add	a1,a1,-1705 # 80208ac7 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.301>
    80206178:	4605                	li	a2,1
    8020617a:	4405                	li	s0,1
    8020617c:	9682                	jalr	a3
    8020617e:	ed11                	bnez	a0,8020619a <.Lpcrel_hi688+0x14>
    80206180:	648c                	ld	a1,8(s1)
    80206182:	6088                	ld	a0,0(s1)
    80206184:	6d94                	ld	a3,24(a1)

0000000080206186 <.Lpcrel_hi688>:
    80206186:	00003597          	auipc	a1,0x3
    8020618a:	82258593          	add	a1,a1,-2014 # 802089a8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.156>
    8020618e:	4605                	li	a2,1
    80206190:	9682                	jalr	a3
    80206192:	842a                	mv	s0,a0
    80206194:	a019                	j	8020619a <.Lpcrel_hi688+0x14>
    80206196:	00b03433          	snez	s0,a1
    8020619a:	8522                	mv	a0,s0
    8020619c:	70e2                	ld	ra,56(sp)
    8020619e:	7442                	ld	s0,48(sp)
    802061a0:	74a2                	ld	s1,40(sp)
    802061a2:	7902                	ld	s2,32(sp)
    802061a4:	69e2                	ld	s3,24(sp)
    802061a6:	6121                	add	sp,sp,64
    802061a8:	8082                	ret

00000000802061aa <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h2440eaa81e730c67E>:
    802061aa:	86ae                	mv	a3,a1
    802061ac:	85aa                	mv	a1,a0
    802061ae:	8532                	mv	a0,a2
    802061b0:	8636                	mv	a2,a3
    802061b2:	00000317          	auipc	t1,0x0
    802061b6:	d0830067          	jr	-760(t1) # 80205eba <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E>

00000000802061ba <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E>:
    802061ba:	1141                	add	sp,sp,-16
    802061bc:	e406                	sd	ra,8(sp)
    802061be:	00758693          	add	a3,a1,7
    802061c2:	9ae1                	and	a3,a3,-8
    802061c4:	0ff57813          	zext.b	a6,a0
    802061c8:	02b68763          	beq	a3,a1,802061f6 <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E+0x3c>
    802061cc:	40b68533          	sub	a0,a3,a1
    802061d0:	00c56363          	bltu	a0,a2,802061d6 <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E+0x1c>
    802061d4:	8532                	mv	a0,a2
    802061d6:	c105                	beqz	a0,802061f6 <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E+0x3c>
    802061d8:	4681                	li	a3,0
    802061da:	00d58733          	add	a4,a1,a3
    802061de:	00074703          	lbu	a4,0(a4)
    802061e2:	09070963          	beq	a4,a6,80206274 <.Lpcrel_hi721+0x68>
    802061e6:	0685                	add	a3,a3,1
    802061e8:	fed519e3          	bne	a0,a3,802061da <_ZN4core5slice6memchr14memchr_aligned17hcf9b92748069c586E+0x20>
    802061ec:	ff060893          	add	a7,a2,-16
    802061f0:	00a8f663          	bgeu	a7,a0,802061fc <.Lpcrel_hi720>
    802061f4:	a8b9                	j	80206252 <.Lpcrel_hi721+0x46>
    802061f6:	4501                	li	a0,0
    802061f8:	ff060893          	add	a7,a2,-16

00000000802061fc <.Lpcrel_hi720>:
    802061fc:	00004697          	auipc	a3,0x4
    80206200:	ffc6b303          	ld	t1,-4(a3) # 8020a1f8 <.LCPI322_0>

0000000080206204 <.Lpcrel_hi722>:
    80206204:	00004697          	auipc	a3,0x4
    80206208:	0046b683          	ld	a3,4(a3) # 8020a208 <.LCPI322_2>

000000008020620c <.Lpcrel_hi721>:
    8020620c:	00004717          	auipc	a4,0x4
    80206210:	ff473383          	ld	t2,-12(a4) # 8020a200 <.LCPI322_1>
    80206214:	02d806b3          	mul	a3,a6,a3
    80206218:	00858293          	add	t0,a1,8
    8020621c:	00a587b3          	add	a5,a1,a0
    80206220:	639c                	ld	a5,0(a5)
    80206222:	8fb5                	xor	a5,a5,a3
    80206224:	fff7c713          	not	a4,a5
    80206228:	979a                	add	a5,a5,t1
    8020622a:	00777733          	and	a4,a4,t2
    8020622e:	8f7d                	and	a4,a4,a5
    80206230:	ef19                	bnez	a4,8020624e <.Lpcrel_hi721+0x42>
    80206232:	00a28733          	add	a4,t0,a0
    80206236:	6318                	ld	a4,0(a4)
    80206238:	8f35                	xor	a4,a4,a3
    8020623a:	fff74793          	not	a5,a4
    8020623e:	971a                	add	a4,a4,t1
    80206240:	0077f7b3          	and	a5,a5,t2
    80206244:	8f7d                	and	a4,a4,a5
    80206246:	e701                	bnez	a4,8020624e <.Lpcrel_hi721+0x42>
    80206248:	0541                	add	a0,a0,16
    8020624a:	fca8f9e3          	bgeu	a7,a0,8020621c <.Lpcrel_hi721+0x10>
    8020624e:	02a66963          	bltu	a2,a0,80206280 <.Lpcrel_hi723>
    80206252:	00c50b63          	beq	a0,a2,80206268 <.Lpcrel_hi721+0x5c>
    80206256:	00a586b3          	add	a3,a1,a0
    8020625a:	0006c683          	lbu	a3,0(a3)
    8020625e:	01068863          	beq	a3,a6,8020626e <.Lpcrel_hi721+0x62>
    80206262:	0505                	add	a0,a0,1
    80206264:	fea619e3          	bne	a2,a0,80206256 <.Lpcrel_hi721+0x4a>
    80206268:	4581                	li	a1,0
    8020626a:	86b2                	mv	a3,a2
    8020626c:	a029                	j	80206276 <.Lpcrel_hi721+0x6a>
    8020626e:	4585                	li	a1,1
    80206270:	86aa                	mv	a3,a0
    80206272:	a011                	j	80206276 <.Lpcrel_hi721+0x6a>
    80206274:	4585                	li	a1,1
    80206276:	852e                	mv	a0,a1
    80206278:	85b6                	mv	a1,a3
    8020627a:	60a2                	ld	ra,8(sp)
    8020627c:	0141                	add	sp,sp,16
    8020627e:	8082                	ret

0000000080206280 <.Lpcrel_hi723>:
    80206280:	00003597          	auipc	a1,0x3
    80206284:	98058693          	add	a3,a1,-1664 # 80208c00 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.347>
    80206288:	85b2                	mv	a1,a2
    8020628a:	8636                	mv	a2,a3
    8020628c:	00000097          	auipc	ra,0x0
    80206290:	00a080e7          	jalr	10(ra) # 80206296 <_ZN4core5slice5index26slice_start_index_len_fail17h6a8d652eb4f6745eE>
	...

0000000080206296 <_ZN4core5slice5index26slice_start_index_len_fail17h6a8d652eb4f6745eE>:
    80206296:	1141                	add	sp,sp,-16
    80206298:	e406                	sd	ra,8(sp)
    8020629a:	00000097          	auipc	ra,0x0
    8020629e:	00a080e7          	jalr	10(ra) # 802062a4 <_ZN4core5slice5index29slice_start_index_len_fail_rt17h8fe2cb03e7a1cc91E>
	...

00000000802062a4 <_ZN4core5slice5index29slice_start_index_len_fail_rt17h8fe2cb03e7a1cc91E>:
    802062a4:	7159                	add	sp,sp,-112
    802062a6:	f486                	sd	ra,104(sp)
    802062a8:	e42a                	sd	a0,8(sp)
    802062aa:	e82e                	sd	a1,16(sp)
    802062ac:	0028                	add	a0,sp,8
    802062ae:	e4aa                	sd	a0,72(sp)

00000000802062b0 <.Lpcrel_hi740>:
    802062b0:	00000517          	auipc	a0,0x0
    802062b4:	4d050513          	add	a0,a0,1232 # 80206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>
    802062b8:	e8aa                	sd	a0,80(sp)
    802062ba:	080c                	add	a1,sp,16
    802062bc:	ecae                	sd	a1,88(sp)
    802062be:	f0aa                	sd	a0,96(sp)

00000000802062c0 <.Lpcrel_hi741>:
    802062c0:	00003517          	auipc	a0,0x3
    802062c4:	99050513          	add	a0,a0,-1648 # 80208c50 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.353>
    802062c8:	f42a                	sd	a0,40(sp)
    802062ca:	4509                	li	a0,2
    802062cc:	f82a                	sd	a0,48(sp)
    802062ce:	ec02                	sd	zero,24(sp)
    802062d0:	00ac                	add	a1,sp,72
    802062d2:	fc2e                	sd	a1,56(sp)
    802062d4:	e0aa                	sd	a0,64(sp)
    802062d6:	0828                	add	a0,sp,24
    802062d8:	85b2                	mv	a1,a2
    802062da:	fffff097          	auipc	ra,0xfffff
    802062de:	252080e7          	jalr	594(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

00000000802062e4 <_ZN4core5slice5index24slice_end_index_len_fail17hebfad67fc831ad67E>:
    802062e4:	1141                	add	sp,sp,-16
    802062e6:	e406                	sd	ra,8(sp)
    802062e8:	00000097          	auipc	ra,0x0
    802062ec:	00a080e7          	jalr	10(ra) # 802062f2 <_ZN4core5slice5index27slice_end_index_len_fail_rt17h3d2b193376549fd0E>
	...

00000000802062f2 <_ZN4core5slice5index27slice_end_index_len_fail_rt17h3d2b193376549fd0E>:
    802062f2:	7159                	add	sp,sp,-112
    802062f4:	f486                	sd	ra,104(sp)
    802062f6:	e42a                	sd	a0,8(sp)
    802062f8:	e82e                	sd	a1,16(sp)
    802062fa:	0028                	add	a0,sp,8
    802062fc:	e4aa                	sd	a0,72(sp)

00000000802062fe <.Lpcrel_hi742>:
    802062fe:	00000517          	auipc	a0,0x0
    80206302:	48250513          	add	a0,a0,1154 # 80206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>
    80206306:	e8aa                	sd	a0,80(sp)
    80206308:	080c                	add	a1,sp,16
    8020630a:	ecae                	sd	a1,88(sp)
    8020630c:	f0aa                	sd	a0,96(sp)

000000008020630e <.Lpcrel_hi743>:
    8020630e:	00003517          	auipc	a0,0x3
    80206312:	96250513          	add	a0,a0,-1694 # 80208c70 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.355>
    80206316:	f42a                	sd	a0,40(sp)
    80206318:	4509                	li	a0,2
    8020631a:	f82a                	sd	a0,48(sp)
    8020631c:	ec02                	sd	zero,24(sp)
    8020631e:	00ac                	add	a1,sp,72
    80206320:	fc2e                	sd	a1,56(sp)
    80206322:	e0aa                	sd	a0,64(sp)
    80206324:	0828                	add	a0,sp,24
    80206326:	85b2                	mv	a1,a2
    80206328:	fffff097          	auipc	ra,0xfffff
    8020632c:	204080e7          	jalr	516(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080206332 <_ZN4core5slice5index22slice_index_order_fail17h05d9627a32fe21dbE>:
    80206332:	1141                	add	sp,sp,-16
    80206334:	e406                	sd	ra,8(sp)
    80206336:	00000097          	auipc	ra,0x0
    8020633a:	00a080e7          	jalr	10(ra) # 80206340 <_ZN4core5slice5index25slice_index_order_fail_rt17ha84e70add61c1f5dE>
	...

0000000080206340 <_ZN4core5slice5index25slice_index_order_fail_rt17ha84e70add61c1f5dE>:
    80206340:	7159                	add	sp,sp,-112
    80206342:	f486                	sd	ra,104(sp)
    80206344:	e42a                	sd	a0,8(sp)
    80206346:	e82e                	sd	a1,16(sp)
    80206348:	0028                	add	a0,sp,8
    8020634a:	e4aa                	sd	a0,72(sp)

000000008020634c <.Lpcrel_hi744>:
    8020634c:	00000517          	auipc	a0,0x0
    80206350:	43450513          	add	a0,a0,1076 # 80206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>
    80206354:	e8aa                	sd	a0,80(sp)
    80206356:	080c                	add	a1,sp,16
    80206358:	ecae                	sd	a1,88(sp)
    8020635a:	f0aa                	sd	a0,96(sp)

000000008020635c <.Lpcrel_hi745>:
    8020635c:	00003517          	auipc	a0,0x3
    80206360:	95c50513          	add	a0,a0,-1700 # 80208cb8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.358>
    80206364:	f42a                	sd	a0,40(sp)
    80206366:	4509                	li	a0,2
    80206368:	f82a                	sd	a0,48(sp)
    8020636a:	ec02                	sd	zero,24(sp)
    8020636c:	00ac                	add	a1,sp,72
    8020636e:	fc2e                	sd	a1,56(sp)
    80206370:	e0aa                	sd	a0,64(sp)
    80206372:	0828                	add	a0,sp,24
    80206374:	85b2                	mv	a1,a2
    80206376:	fffff097          	auipc	ra,0xfffff
    8020637a:	1b6080e7          	jalr	438(ra) # 8020552c <_ZN4core9panicking9panic_fmt17h7731889270b75e03E>
	...

0000000080206380 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E>:
    80206380:	862a                	mv	a2,a0
    80206382:	00750713          	add	a4,a0,7
    80206386:	9b61                	and	a4,a4,-8
    80206388:	40a702b3          	sub	t0,a4,a0
    8020638c:	0055ec63          	bltu	a1,t0,802063a4 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x24>
    80206390:	40558833          	sub	a6,a1,t0
    80206394:	00883693          	sltiu	a3,a6,8
    80206398:	0092b793          	sltiu	a5,t0,9
    8020639c:	0017c793          	xor	a5,a5,1
    802063a0:	8edd                	or	a3,a3,a5
    802063a2:	ce91                	beqz	a3,802063be <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x3e>
    802063a4:	4501                	li	a0,0
    802063a6:	c999                	beqz	a1,802063bc <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x3c>
    802063a8:	00060683          	lb	a3,0(a2)
    802063ac:	0605                	add	a2,a2,1
    802063ae:	fc06a693          	slti	a3,a3,-64
    802063b2:	0016c693          	xor	a3,a3,1
    802063b6:	15fd                	add	a1,a1,-1
    802063b8:	9536                	add	a0,a0,a3
    802063ba:	f5fd                	bnez	a1,802063a8 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x28>
    802063bc:	8082                	ret
    802063be:	00787693          	and	a3,a6,7
    802063c2:	4581                	li	a1,0
    802063c4:	00c70f63          	beq	a4,a2,802063e2 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x62>
    802063c8:	40e60733          	sub	a4,a2,a4
    802063cc:	87b2                	mv	a5,a2
    802063ce:	00078503          	lb	a0,0(a5)
    802063d2:	0785                	add	a5,a5,1
    802063d4:	fc052513          	slti	a0,a0,-64
    802063d8:	00154513          	xor	a0,a0,1
    802063dc:	0705                	add	a4,a4,1
    802063de:	95aa                	add	a1,a1,a0
    802063e0:	f77d                	bnez	a4,802063ce <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x4e>
    802063e2:	92b2                	add	t0,t0,a2
    802063e4:	4601                	li	a2,0
    802063e6:	ce91                	beqz	a3,80206402 <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x82>
    802063e8:	ff887713          	and	a4,a6,-8
    802063ec:	9716                	add	a4,a4,t0
    802063ee:	00070503          	lb	a0,0(a4)
    802063f2:	0705                	add	a4,a4,1
    802063f4:	fc052513          	slti	a0,a0,-64
    802063f8:	00154513          	xor	a0,a0,1
    802063fc:	16fd                	add	a3,a3,-1
    802063fe:	962a                	add	a2,a2,a0
    80206400:	f6fd                	bnez	a3,802063ee <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x6e>
    80206402:	00385713          	srl	a4,a6,0x3

0000000080206406 <.Lpcrel_hi765>:
    80206406:	00004517          	auipc	a0,0x4
    8020640a:	e3253f03          	ld	t5,-462(a0) # 8020a238 <.LCPI346_0>

000000008020640e <.Lpcrel_hi766>:
    8020640e:	00004517          	auipc	a0,0x4
    80206412:	e3253883          	ld	a7,-462(a0) # 8020a240 <.LCPI346_1>
    80206416:	10001537          	lui	a0,0x10001
    8020641a:	0512                	sll	a0,a0,0x4
    8020641c:	0505                	add	a0,a0,1 # 10001001 <.Lline_table_start0+0xffbb7b8>
    8020641e:	0542                	sll	a0,a0,0x10
    80206420:	00150813          	add	a6,a0,1
    80206424:	00b60533          	add	a0,a2,a1
    80206428:	a01d                	j	8020644e <.Lpcrel_hi766+0x40>
    8020642a:	003e1293          	sll	t0,t3,0x3
    8020642e:	929a                	add	t0,t0,t1
    80206430:	41c38733          	sub	a4,t2,t3
    80206434:	003e7613          	and	a2,t3,3
    80206438:	0115f6b3          	and	a3,a1,a7
    8020643c:	81a1                	srl	a1,a1,0x8
    8020643e:	0115f5b3          	and	a1,a1,a7
    80206442:	95b6                	add	a1,a1,a3
    80206444:	030585b3          	mul	a1,a1,a6
    80206448:	91c1                	srl	a1,a1,0x30
    8020644a:	952e                	add	a0,a0,a1
    8020644c:	ee35                	bnez	a2,802064c8 <.Lpcrel_hi766+0xba>
    8020644e:	d73d                	beqz	a4,802063bc <_ZN4core3str5count14do_count_chars17hd1620c02414f8ea4E+0x3c>
    80206450:	83ba                	mv	t2,a4
    80206452:	8316                	mv	t1,t0
    80206454:	0c000593          	li	a1,192
    80206458:	8e3a                	mv	t3,a4
    8020645a:	00b76463          	bltu	a4,a1,80206462 <.Lpcrel_hi766+0x54>
    8020645e:	0c000e13          	li	t3,192
    80206462:	0fce7593          	and	a1,t3,252
    80206466:	00359793          	sll	a5,a1,0x3
    8020646a:	00f30eb3          	add	t4,t1,a5
    8020646e:	ddd5                	beqz	a1,8020642a <.Lpcrel_hi766+0x1c>
    80206470:	4581                	li	a1,0
    80206472:	861a                	mv	a2,t1
    80206474:	da5d                	beqz	a2,8020642a <.Lpcrel_hi766+0x1c>
    80206476:	6218                	ld	a4,0(a2)
    80206478:	fff74793          	not	a5,a4
    8020647c:	839d                	srl	a5,a5,0x7
    8020647e:	8319                	srl	a4,a4,0x6
    80206480:	6614                	ld	a3,8(a2)
    80206482:	8f5d                	or	a4,a4,a5
    80206484:	01e77733          	and	a4,a4,t5
    80206488:	95ba                	add	a1,a1,a4
    8020648a:	fff6c713          	not	a4,a3
    8020648e:	831d                	srl	a4,a4,0x7
    80206490:	6a1c                	ld	a5,16(a2)
    80206492:	8299                	srl	a3,a3,0x6
    80206494:	8ed9                	or	a3,a3,a4
    80206496:	01e6f6b3          	and	a3,a3,t5
    8020649a:	fff7c713          	not	a4,a5
    8020649e:	831d                	srl	a4,a4,0x7
    802064a0:	8399                	srl	a5,a5,0x6
    802064a2:	8f5d                	or	a4,a4,a5
    802064a4:	6e1c                	ld	a5,24(a2)
    802064a6:	01e77733          	and	a4,a4,t5
    802064aa:	96ba                	add	a3,a3,a4
    802064ac:	95b6                	add	a1,a1,a3
    802064ae:	fff7c693          	not	a3,a5
    802064b2:	829d                	srl	a3,a3,0x7
    802064b4:	8399                	srl	a5,a5,0x6
    802064b6:	8edd                	or	a3,a3,a5
    802064b8:	01e6f6b3          	and	a3,a3,t5
    802064bc:	02060613          	add	a2,a2,32
    802064c0:	95b6                	add	a1,a1,a3
    802064c2:	fbd619e3          	bne	a2,t4,80206474 <.Lpcrel_hi766+0x66>
    802064c6:	b795                	j	8020642a <.Lpcrel_hi766+0x1c>
    802064c8:	02030a63          	beqz	t1,802064fc <.Lpcrel_hi766+0xee>
    802064cc:	0c000593          	li	a1,192
    802064d0:	00b3e463          	bltu	t2,a1,802064d8 <.Lpcrel_hi766+0xca>
    802064d4:	0c000393          	li	t2,192
    802064d8:	4581                	li	a1,0
    802064da:	0033f613          	and	a2,t2,3
    802064de:	060e                	sll	a2,a2,0x3
    802064e0:	000eb683          	ld	a3,0(t4)
    802064e4:	0ea1                	add	t4,t4,8
    802064e6:	fff6c713          	not	a4,a3
    802064ea:	831d                	srl	a4,a4,0x7
    802064ec:	8299                	srl	a3,a3,0x6
    802064ee:	8ed9                	or	a3,a3,a4
    802064f0:	01e6f6b3          	and	a3,a3,t5
    802064f4:	1661                	add	a2,a2,-8
    802064f6:	95b6                	add	a1,a1,a3
    802064f8:	f665                	bnez	a2,802064e0 <.Lpcrel_hi766+0xd2>
    802064fa:	a011                	j	802064fe <.Lpcrel_hi766+0xf0>
    802064fc:	4581                	li	a1,0
    802064fe:	0115f633          	and	a2,a1,a7
    80206502:	81a1                	srl	a1,a1,0x8
    80206504:	0115f5b3          	and	a1,a1,a7
    80206508:	95b2                	add	a1,a1,a2
    8020650a:	030585b3          	mul	a1,a1,a6
    8020650e:	91c1                	srl	a1,a1,0x30
    80206510:	952e                	add	a0,a0,a1
    80206512:	8082                	ret

0000000080206514 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E>:
    80206514:	7175                	add	sp,sp,-144
    80206516:	e506                	sd	ra,136(sp)
    80206518:	882e                	mv	a6,a1
    8020651a:	4781                	li	a5,0
    8020651c:	4114                	lw	a3,0(a0)
    8020651e:	0130                	add	a2,sp,136
    80206520:	48a9                	li	a7,10
    80206522:	42bd                	li	t0,15
    80206524:	a821                	j	8020653c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E+0x28>
    80206526:	fff60713          	add	a4,a2,-1
    8020652a:	0045569b          	srlw	a3,a0,0x4
    8020652e:	959a                	add	a1,a1,t1
    80206530:	feb60fa3          	sb	a1,-1(a2)
    80206534:	0785                	add	a5,a5,1
    80206536:	863a                	mv	a2,a4
    80206538:	00a2fc63          	bgeu	t0,a0,80206550 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E+0x3c>
    8020653c:	8536                	mv	a0,a3
    8020653e:	00f6f593          	and	a1,a3,15
    80206542:	03000313          	li	t1,48
    80206546:	ff15e0e3          	bltu	a1,a7,80206526 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E+0x12>
    8020654a:	03700313          	li	t1,55
    8020654e:	bfe1                	j	80206526 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h5f82d63157768593E+0x12>
    80206550:	08000513          	li	a0,128
    80206554:	8d1d                	sub	a0,a0,a5
    80206556:	08100593          	li	a1,129
    8020655a:	02b57063          	bgeu	a0,a1,8020657a <.Lpcrel_hi1429>

000000008020655e <.Lpcrel_hi1430>:
    8020655e:	00002517          	auipc	a0,0x2
    80206562:	5a250613          	add	a2,a0,1442 # 80208b00 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.320>
    80206566:	4585                	li	a1,1
    80206568:	4689                	li	a3,2
    8020656a:	8542                	mv	a0,a6
    8020656c:	fffff097          	auipc	ra,0xfffff
    80206570:	6de080e7          	jalr	1758(ra) # 80205c4a <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE>
    80206574:	60aa                	ld	ra,136(sp)
    80206576:	6149                	add	sp,sp,144
    80206578:	8082                	ret

000000008020657a <.Lpcrel_hi1429>:
    8020657a:	00002597          	auipc	a1,0x2
    8020657e:	56e58613          	add	a2,a1,1390 # 80208ae8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.319>
    80206582:	08000593          	li	a1,128
    80206586:	00000097          	auipc	ra,0x0
    8020658a:	d10080e7          	jalr	-752(ra) # 80206296 <_ZN4core5slice5index26slice_start_index_len_fail17h6a8d652eb4f6745eE>
	...

0000000080206590 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E>:
    80206590:	7175                	add	sp,sp,-144
    80206592:	e506                	sd	ra,136(sp)
    80206594:	882e                	mv	a6,a1
    80206596:	4781                	li	a5,0
    80206598:	6114                	ld	a3,0(a0)
    8020659a:	0130                	add	a2,sp,136
    8020659c:	48a9                	li	a7,10
    8020659e:	42bd                	li	t0,15
    802065a0:	a821                	j	802065b8 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E+0x28>
    802065a2:	fff60713          	add	a4,a2,-1
    802065a6:	00455693          	srl	a3,a0,0x4
    802065aa:	959a                	add	a1,a1,t1
    802065ac:	feb60fa3          	sb	a1,-1(a2)
    802065b0:	0785                	add	a5,a5,1
    802065b2:	863a                	mv	a2,a4
    802065b4:	00a2fc63          	bgeu	t0,a0,802065cc <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E+0x3c>
    802065b8:	8536                	mv	a0,a3
    802065ba:	00f6f593          	and	a1,a3,15
    802065be:	03000313          	li	t1,48
    802065c2:	ff15e0e3          	bltu	a1,a7,802065a2 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E+0x12>
    802065c6:	05700313          	li	t1,87
    802065ca:	bfe1                	j	802065a2 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17ha8793cbd06c55ad3E+0x12>
    802065cc:	08000513          	li	a0,128
    802065d0:	8d1d                	sub	a0,a0,a5
    802065d2:	08100593          	li	a1,129
    802065d6:	02b57063          	bgeu	a0,a1,802065f6 <.Lpcrel_hi1435>

00000000802065da <.Lpcrel_hi1436>:
    802065da:	00002517          	auipc	a0,0x2
    802065de:	52650613          	add	a2,a0,1318 # 80208b00 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.320>
    802065e2:	4585                	li	a1,1
    802065e4:	4689                	li	a3,2
    802065e6:	8542                	mv	a0,a6
    802065e8:	fffff097          	auipc	ra,0xfffff
    802065ec:	662080e7          	jalr	1634(ra) # 80205c4a <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE>
    802065f0:	60aa                	ld	ra,136(sp)
    802065f2:	6149                	add	sp,sp,144
    802065f4:	8082                	ret

00000000802065f6 <.Lpcrel_hi1435>:
    802065f6:	00002597          	auipc	a1,0x2
    802065fa:	4f258613          	add	a2,a1,1266 # 80208ae8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.319>
    802065fe:	08000593          	li	a1,128
    80206602:	00000097          	auipc	ra,0x0
    80206606:	c94080e7          	jalr	-876(ra) # 80206296 <_ZN4core5slice5index26slice_start_index_len_fail17h6a8d652eb4f6745eE>
	...

000000008020660c <_ZN4core3fmt3num3imp7fmt_u6417hdc88f43bf250c07cE>:
    8020660c:	7139                	add	sp,sp,-64
    8020660e:	fc06                	sd	ra,56(sp)
    80206610:	f822                	sd	s0,48(sp)
    80206612:	f426                	sd	s1,40(sp)
    80206614:	8832                	mv	a6,a2
    80206616:	00455693          	srl	a3,a0,0x4
    8020661a:	02700713          	li	a4,39
    8020661e:	27100793          	li	a5,625

0000000080206622 <.Lpcrel_hi1479>:
    80206622:	00002617          	auipc	a2,0x2
    80206626:	4e060e93          	add	t4,a2,1248 # 80208b02 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.323>
    8020662a:	02f6f363          	bgeu	a3,a5,80206650 <.Lpcrel_hi1479+0x2e>
    8020662e:	06300693          	li	a3,99
    80206632:	0aa6ea63          	bltu	a3,a0,802066e6 <.Lpcrel_hi1480+0x8c>
    80206636:	4629                	li	a2,10
    80206638:	0ec57863          	bgeu	a0,a2,80206728 <.Lpcrel_hi1480+0xce>
    8020663c:	fff70693          	add	a3,a4,-1
    80206640:	00110613          	add	a2,sp,1
    80206644:	9636                	add	a2,a2,a3
    80206646:	0305051b          	addw	a0,a0,48
    8020664a:	00a60023          	sb	a0,0(a2)
    8020664e:	a8e5                	j	80206746 <.Lpcrel_hi1480+0xec>
    80206650:	4701                	li	a4,0
    80206652:	02410893          	add	a7,sp,36
    80206656:	02610293          	add	t0,sp,38

000000008020665a <.Lpcrel_hi1480>:
    8020665a:	00004697          	auipc	a3,0x4
    8020665e:	c966b303          	ld	t1,-874(a3) # 8020a2f0 <.LCPI640_0>
    80206662:	6689                	lui	a3,0x2
    80206664:	71068e1b          	addw	t3,a3,1808 # 2710 <.Lline_table_start0+0x274>
    80206668:	6685                	lui	a3,0x1
    8020666a:	47b68f1b          	addw	t5,a3,1147 # 147b <.Lline_table_start0+0x165>
    8020666e:	06400393          	li	t2,100
    80206672:	05f5e6b7          	lui	a3,0x5f5e
    80206676:	0ff68f9b          	addw	t6,a3,255 # 5f5e0ff <.Lline_table_start0+0x5f188b6>
    8020667a:	86aa                	mv	a3,a0
    8020667c:	02653533          	mulhu	a0,a0,t1
    80206680:	812d                	srl	a0,a0,0xb
    80206682:	03c507bb          	mulw	a5,a0,t3
    80206686:	40f6863b          	subw	a2,a3,a5
    8020668a:	03061793          	sll	a5,a2,0x30
    8020668e:	93c9                	srl	a5,a5,0x32
    80206690:	03e787b3          	mul	a5,a5,t5
    80206694:	0117d413          	srl	s0,a5,0x11
    80206698:	83c1                	srl	a5,a5,0x10
    8020669a:	7fe7f793          	and	a5,a5,2046
    8020669e:	0274043b          	mulw	s0,s0,t2
    802066a2:	9e01                	subw	a2,a2,s0
    802066a4:	1646                	sll	a2,a2,0x31
    802066a6:	97f6                	add	a5,a5,t4
    802066a8:	0017c403          	lbu	s0,1(a5)
    802066ac:	9241                	srl	a2,a2,0x30
    802066ae:	00e884b3          	add	s1,a7,a4
    802066b2:	0007c783          	lbu	a5,0(a5)
    802066b6:	008480a3          	sb	s0,1(s1)
    802066ba:	9676                	add	a2,a2,t4
    802066bc:	00164403          	lbu	s0,1(a2)
    802066c0:	00064603          	lbu	a2,0(a2)
    802066c4:	00f48023          	sb	a5,0(s1)
    802066c8:	00e287b3          	add	a5,t0,a4
    802066cc:	008780a3          	sb	s0,1(a5)
    802066d0:	00c78023          	sb	a2,0(a5)
    802066d4:	1771                	add	a4,a4,-4
    802066d6:	fadfe2e3          	bltu	t6,a3,8020667a <.Lpcrel_hi1480+0x20>
    802066da:	02770713          	add	a4,a4,39
    802066de:	06300693          	li	a3,99
    802066e2:	f4a6fae3          	bgeu	a3,a0,80206636 <.Lpcrel_hi1479+0x14>
    802066e6:	03051613          	sll	a2,a0,0x30
    802066ea:	9249                	srl	a2,a2,0x32
    802066ec:	6685                	lui	a3,0x1
    802066ee:	47b6869b          	addw	a3,a3,1147 # 147b <.Lline_table_start0+0x165>
    802066f2:	02d60633          	mul	a2,a2,a3
    802066f6:	8245                	srl	a2,a2,0x11
    802066f8:	06400693          	li	a3,100
    802066fc:	02d606bb          	mulw	a3,a2,a3
    80206700:	9d15                	subw	a0,a0,a3
    80206702:	1546                	sll	a0,a0,0x31
    80206704:	9141                	srl	a0,a0,0x30
    80206706:	1779                	add	a4,a4,-2
    80206708:	9576                	add	a0,a0,t4
    8020670a:	00154683          	lbu	a3,1(a0)
    8020670e:	00054503          	lbu	a0,0(a0)
    80206712:	00110793          	add	a5,sp,1
    80206716:	97ba                	add	a5,a5,a4
    80206718:	00d780a3          	sb	a3,1(a5)
    8020671c:	00a78023          	sb	a0,0(a5)
    80206720:	8532                	mv	a0,a2
    80206722:	4629                	li	a2,10
    80206724:	f0c56ce3          	bltu	a0,a2,8020663c <.Lpcrel_hi1479+0x1a>
    80206728:	0506                	sll	a0,a0,0x1
    8020672a:	ffe70693          	add	a3,a4,-2
    8020672e:	9576                	add	a0,a0,t4
    80206730:	00154603          	lbu	a2,1(a0)
    80206734:	00054503          	lbu	a0,0(a0)
    80206738:	00110713          	add	a4,sp,1
    8020673c:	9736                	add	a4,a4,a3
    8020673e:	00c700a3          	sb	a2,1(a4)
    80206742:	00a70023          	sb	a0,0(a4)
    80206746:	00110713          	add	a4,sp,1
    8020674a:	9736                	add	a4,a4,a3
    8020674c:	02700793          	li	a5,39
    80206750:	8f95                	sub	a5,a5,a3

0000000080206752 <.Lpcrel_hi1481>:
    80206752:	00002517          	auipc	a0,0x2
    80206756:	25650613          	add	a2,a0,598 # 802089a8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.156>
    8020675a:	8542                	mv	a0,a6
    8020675c:	4681                	li	a3,0
    8020675e:	fffff097          	auipc	ra,0xfffff
    80206762:	4ec080e7          	jalr	1260(ra) # 80205c4a <_ZN4core3fmt9Formatter12pad_integral17ha059a5a32c02880bE>
    80206766:	70e2                	ld	ra,56(sp)
    80206768:	7442                	ld	s0,48(sp)
    8020676a:	74a2                	ld	s1,40(sp)
    8020676c:	6121                	add	sp,sp,64
    8020676e:	8082                	ret

0000000080206770 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h7520ca2061eddddcE>:
    80206770:	00056503          	lwu	a0,0(a0)
    80206774:	862e                	mv	a2,a1
    80206776:	4585                	li	a1,1
    80206778:	00000317          	auipc	t1,0x0
    8020677c:	e9430067          	jr	-364(t1) # 8020660c <_ZN4core3fmt3num3imp7fmt_u6417hdc88f43bf250c07cE>

0000000080206780 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h944e210ee4f6a570E>:
    80206780:	6108                	ld	a0,0(a0)
    80206782:	862e                	mv	a2,a1
    80206784:	4585                	li	a1,1
    80206786:	00000317          	auipc	t1,0x0
    8020678a:	e8630067          	jr	-378(t1) # 8020660c <_ZN4core3fmt3num3imp7fmt_u6417hdc88f43bf250c07cE>

000000008020678e <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h5e4dc2ec9562c4bdE>:
    8020678e:	6590                	ld	a2,8(a1)
    80206790:	6188                	ld	a0,0(a1)
    80206792:	6e1c                	ld	a5,24(a2)

0000000080206794 <.Lpcrel_hi1504>:
    80206794:	00002597          	auipc	a1,0x2
    80206798:	54458593          	add	a1,a1,1348 # 80208cd8 <.Lanon.7b11bb158216d7ac08c6d28e26e8610d.686>
    8020679c:	4615                	li	a2,5
    8020679e:	8782                	jr	a5

00000000802067a0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h70355f0e3287a670E>:
    802067a0:	6510                	ld	a2,8(a0)
    802067a2:	6108                	ld	a0,0(a0)
    802067a4:	6e1c                	ld	a5,24(a2)
    802067a6:	8782                	jr	a5

00000000802067a8 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf8ad0eea45758417E>:
    802067a8:	6114                	ld	a3,0(a0)
    802067aa:	6510                	ld	a2,8(a0)
    802067ac:	852e                	mv	a0,a1
    802067ae:	85b6                	mv	a1,a3
    802067b0:	fffff317          	auipc	t1,0xfffff
    802067b4:	70a30067          	jr	1802(t1) # 80205eba <_ZN4core3fmt9Formatter3pad17h47448ac62163e813E>

00000000802067b8 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E>:
    802067b8:	46bd                	li	a3,15
    802067ba:	06c6f963          	bgeu	a3,a2,8020682c <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x74>
    802067be:	40a006bb          	negw	a3,a0
    802067c2:	0076f813          	and	a6,a3,7
    802067c6:	010503b3          	add	t2,a0,a6
    802067ca:	00080c63          	beqz	a6,802067e2 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x2a>
    802067ce:	87aa                	mv	a5,a0
    802067d0:	86ae                	mv	a3,a1
    802067d2:	00068703          	lb	a4,0(a3)
    802067d6:	00e78023          	sb	a4,0(a5)
    802067da:	0785                	add	a5,a5,1
    802067dc:	0685                	add	a3,a3,1
    802067de:	fe77eae3          	bltu	a5,t2,802067d2 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x1a>
    802067e2:	010588b3          	add	a7,a1,a6
    802067e6:	41060833          	sub	a6,a2,a6
    802067ea:	ff887293          	and	t0,a6,-8
    802067ee:	0078f313          	and	t1,a7,7
    802067f2:	005386b3          	add	a3,t2,t0
    802067f6:	02030e63          	beqz	t1,80206832 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x7a>
    802067fa:	04505663          	blez	t0,80206846 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x8e>
    802067fe:	030e                	sll	t1,t1,0x3
    80206800:	ff88f793          	and	a5,a7,-8
    80206804:	6390                	ld	a2,0(a5)
    80206806:	406005bb          	negw	a1,t1
    8020680a:	0385fe13          	and	t3,a1,56
    8020680e:	07a1                	add	a5,a5,8
    80206810:	6398                	ld	a4,0(a5)
    80206812:	00665633          	srl	a2,a2,t1
    80206816:	01c715b3          	sll	a1,a4,t3
    8020681a:	8dd1                	or	a1,a1,a2
    8020681c:	00b3b023          	sd	a1,0(t2) # 10000 <.Lline_table_start0+0x236>
    80206820:	03a1                	add	t2,t2,8
    80206822:	07a1                	add	a5,a5,8
    80206824:	863a                	mv	a2,a4
    80206826:	fed3e5e3          	bltu	t2,a3,80206810 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x58>
    8020682a:	a831                	j	80206846 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x8e>
    8020682c:	86aa                	mv	a3,a0
    8020682e:	e20d                	bnez	a2,80206850 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x98>
    80206830:	a80d                	j	80206862 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0xaa>
    80206832:	00505a63          	blez	t0,80206846 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x8e>
    80206836:	85c6                	mv	a1,a7
    80206838:	6190                	ld	a2,0(a1)
    8020683a:	00c3b023          	sd	a2,0(t2)
    8020683e:	03a1                	add	t2,t2,8
    80206840:	05a1                	add	a1,a1,8
    80206842:	fed3ebe3          	bltu	t2,a3,80206838 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x80>
    80206846:	005885b3          	add	a1,a7,t0
    8020684a:	00787613          	and	a2,a6,7
    8020684e:	ca11                	beqz	a2,80206862 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0xaa>
    80206850:	9636                	add	a2,a2,a3
    80206852:	00058703          	lb	a4,0(a1)
    80206856:	00e68023          	sb	a4,0(a3)
    8020685a:	0685                	add	a3,a3,1
    8020685c:	0585                	add	a1,a1,1
    8020685e:	fec6eae3          	bltu	a3,a2,80206852 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E+0x9a>
    80206862:	8082                	ret

0000000080206864 <memcpy>:
    80206864:	00000317          	auipc	t1,0x0
    80206868:	f5430067          	jr	-172(t1) # 802067b8 <_ZN17compiler_builtins3mem6memcpy17h0183788949fc77b9E>
