/* mac_counter__program_3009 @ 0x921fc0, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 * Зовут его: txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_sysassert
 */
	.section .text.mac_counter__program_3009,"ax",@progbits
	.global mac_counter__program_3009
mac_counter__program_3009:
	.global L_921fc0
L_921fc0:
	push_s blink
L_921fc2:
	bl L_920214
L_921fc6:
	ld_s r13,[r0,0x4]
L_921fc8:
	ld_s r14,[r0]
L_921fca:
	mov_s r0,0x886500
L_921fd0:
	ld_s r0,[r0,0x6c]
L_921fd2:
	bmsk.f 0x0,r0,0x3
L_921fd6:
	beq_s L_921fea
L_921fd8:
	mov_s r0,blink
L_921fda:
	mov_s r2,0x1001c78
L_921fe0:
	mov_s r1,0x3
L_921fe2:
	bl.d L_925548
L_921fe6:
	mov r3,0x154
	.global L_921fea
L_921fea:
	mov_s r0,0x1c000006
L_921ff0:
	mov_s r32,r0
L_921ff2:
	st.ab r0,[r25,0x4]
L_921ff6:
	bclr r25,r25,0xa
L_921ffa:
	asl_s r0,r13,0x4
L_921ffc:
	or r0,r0,0x46003009
L_922004:
	mov_s r32,r0
L_922006:
	st.ab r0,[r25,0x4]
L_92200a:
	bclr r25,r25,0xa
L_92200e:
	mov_s r1,0x801458
L_922014:
	ld_s r0,[r1,0x14]
L_922016:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922018:
	st_s r0,[r1,0x14]
	.global L_92201a
L_92201a:
	mov_s r0,r53
L_92201c:
	bbit0 r0,0x2,L_92201a
L_922020:
	ld_s r0,[gp,-0x44]
L_922022:
	and r0,r0,0xfff0ffff
L_92202a:
	bset r1,r0,0x10
L_92202e:
	or r0,r0,0x1d010000
L_922036:
	st.as r1,[gp,-0x11]
L_92203a:
	mov_s r32,r0
L_92203c:
	st.ab r0,[r25,0x4]
L_922040:
	bclr r25,r25,0xa
L_922044:
	nop_s
L_922046:
	nop_s
L_922048:
	nop_s
	.global L_92204a
L_92204a:
	mov_s r0,r47
L_92204c:
	bbit1 r0,0x0,L_92204a
L_922050:
	asl_s r14,r14,0x8
L_922052:
	bset_s r14,r14,0x1a
L_922054:
	bset_s r14,r14,0x1e
L_922056:
	or_s r13,r13,r14
L_922058:
	bset_s r13,r13,0x13
L_92205a:
	bset_s r13,r13,0x15
L_92205c:
	mov_s r32,r13
L_92205e:
	st.ab r13,[r25,0x4]
L_922062:
	bclr r25,r25,0xa
L_922066:
	mov_s r0,0x45000001
L_92206c:
	mov_s r32,r0
L_92206e:
	st.ab r0,[r25,0x4]
L_922072:
	bclr r25,r25,0xa
L_922076:
	mov_s r0,0x460001f1
L_92207c:
	mov_s r32,r0
L_92207e:
	st.ab r0,[r25,0x4]
L_922082:
	bclr r25,r25,0xa
L_922086:
	b L_920284
L_92208a:
	nop_s
