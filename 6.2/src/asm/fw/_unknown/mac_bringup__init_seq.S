/* mac_bringup__init_seq @ 0x8fa6c4, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w12, bits__set32_s0_w4, bits__set32_s12_w12, bits__set32_s16_w12, bits__set32_s4_w12, macq_desc__write, qdesc__build_by_type, rf_chain__program_sector_desc, rf_chain__zero_and_program, tx_queue__config_by_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__init_seq
mac_bringup__init_seq:
	.global L_8fa6c4
L_8fa6c4:
	push_s blink
L_8fa6c6:
	bl.d L_8c01e0
L_8fa6ca:
	mov_s r1,0xa
L_8fa6cc:
	sub_s sp,sp,0x60
L_8fa6ce:
	mov_s r14,0x0
L_8fa6d0:
	mov_s r13,sp
L_8fa6d2:
	mov_s r0,r13
L_8fa6d4:
	mov_s r2,r14
L_8fa6d6:
	mov_s r3,r14
L_8fa6d8:
	mov_s r4,r1
L_8fa6da:
	bl.d L_8fa398
L_8fa6de:
	mov_s r5,r14
L_8fa6e0:
	mov_s r0,r13
L_8fa6e2:
	mov_s r1,0x1f
L_8fa6e4:
	mov_s r13,0x2
L_8fa6e6:
	mov_s r2,r13
L_8fa6e8:
	mov_s r3,r14
L_8fa6ea:
	mov_s r4,r14
L_8fa6ec:
	mov_s r5,r14
L_8fa6ee:
	mov r6,0x1
L_8fa6f2:
	bl.d L_8c5010
L_8fa6f6:
	mov r7,r6
L_8fa6fa:
	add_s r15,sp,0x10
L_8fa6fc:
	mov_s r0,r15
L_8fa6fe:
	bl.d L_8f9fb0
L_8fa702:
	mov_s r1,0xa
L_8fa704:
	mov_s r0,r15
L_8fa706:
	mov_s r1,0x1f
L_8fa708:
	mov_s r2,r13
L_8fa70a:
	mov_s r3,r14
L_8fa70c:
	mov_s r4,r14
L_8fa70e:
	mov_s r5,r14
L_8fa710:
	mov_s r6,r13
L_8fa712:
	bl.d L_8c5010
L_8fa716:
	mov r7,0x1
L_8fa71a:
	add_s r15,sp,0x20
L_8fa71c:
	mov_s r0,r15
L_8fa71e:
	mov_s r1,0xa
L_8fa720:
	mov_s r2,r14
L_8fa722:
	mov_s r3,0x6
L_8fa724:
	mov_s r4,r14
L_8fa726:
	mov_s r5,r14
L_8fa728:
	bl.d L_8fa224
L_8fa72c:
	mov r6,0x1
L_8fa730:
	mov_s r0,r15
L_8fa732:
	mov_s r1,0x1f
L_8fa734:
	mov_s r2,r13
L_8fa736:
	mov_s r3,0x3
L_8fa738:
	mov_s r4,r14
L_8fa73a:
	mov_s r5,r14
L_8fa73c:
	mov_s r6,r14
L_8fa73e:
	bl.d L_8c5010
L_8fa742:
	mov_s r7,r3
L_8fa744:
	stw r14,[sp, 0x50]
L_8fa748:
	stw r14,[sp, 0x52]
L_8fa74c:
	stw r14,[sp, 0x56]
L_8fa750:
	add_s r0,sp,0x58
L_8fa752:
	mov_s r1,r13
L_8fa754:
	bl.d L_8ed340
L_8fa758:
	stw r14,[sp, 0x54]
L_8fa75c:
	mov r1,0x1ff
L_8fa760:
	bl.d L_8ed3a0
L_8fa764:
	mov_s r2,r13
L_8fa766:
	mov_s r0,0xff
L_8fa768:
	stb r0,[sp, 0x5b]
L_8fa76c:
	add_s r0,sp,0x5c
L_8fa76e:
	mov_s r1,0x1
L_8fa770:
	bl.d L_8ed370
L_8fa774:
	mov_s r3,r14
L_8fa776:
	mov r1,0x1ff
L_8fa77a:
	bl.d L_8ed3e8
L_8fa77e:
	mov_s r4,r14
L_8fa780:
	mov_s r1,0x1
L_8fa782:
	bl.d L_8ed4f0
L_8fa786:
	mov_s r5,r14
L_8fa788:
	add_s r0,sp,0x50
L_8fa78a:
	mov_s r1,0x1f
L_8fa78c:
	mov_s r6,r14
L_8fa78e:
	bl.d L_8c5010
L_8fa792:
	mov r7,0x1
L_8fa796:
	bl.d L_8ea398
L_8fa79a:
	mov r0,0x1ff
L_8fa79e:
	b.d L_8c024c
L_8fa7a2:
	add_s sp,sp,0x60
