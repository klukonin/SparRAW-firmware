/* mid__inject_sm_event @ 0x8e1e8c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event
 */
	.section .text.mid__inject_sm_event,"ax",@progbits
	.global mid__inject_sm_event
mid__inject_sm_event:
L_8e1e8c:
	sub_s sp,sp,0x8
L_8e1e8e:
	push_s blink
L_8e1e90:
	bl.d L_8c02c0
L_8e1e94:
	mov_s r8,r3
L_8e1e96:
	sub_s sp,sp,0x28
L_8e1e98:
	mov_s r15,r2
L_8e1e9a:
	mov_s r14,r5
L_8e1e9c:
	mov_s r13,r6
L_8e1e9e:
	mov_s r3,r7
L_8e1ea0:
	mov_s r2,0x0
L_8e1ea2:
	add_s r0,r0,0x28
L_8e1ea4:
	cmp_s r1,0x0
L_8e1ea6:
	mov_s r1,0x8
L_8e1ea8:
	beq_s L_8e1ec6
L_8e1eaa:
	st r8,[sp, 0x18]
L_8e1eae:
	st r4,[sp, 0x1c]
L_8e1eb2:
	st_s r14,[sp,0x20]
L_8e1eb4:
	st_s r13,[sp,0xc]
L_8e1eb6:
	st_s r2,[sp,0x8]
L_8e1eb8:
	st_s r15,[sp,0x0]
L_8e1eba:
	mov_s r1,0x1
L_8e1ebc:
	st_s r1,[sp,0x4]
L_8e1ebe:
	stb_s r3,[sp,0x24]
L_8e1ec0:
	mov_s r3,sp
L_8e1ec2:
	mov_s r1,r2
L_8e1ec4:
	mov_s r2,r3
	.global L_8e1ec6
L_8e1ec6:
	mov_s r3,0x0
L_8e1ec8:
	bl.d L_8d6a1c
L_8e1ecc:
	mov_s r4,r3
L_8e1ece:
	mov_s r12,0xc
L_8e1ed0:
	b.d L_8c032e
L_8e1ed4:
	add_s sp,sp,0x28
L_8e1ed6:
	nop_s
