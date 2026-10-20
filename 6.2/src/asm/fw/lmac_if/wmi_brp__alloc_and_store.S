/* wmi_brp__alloc_and_store @ 0x8db598, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_brp_set_ant_limit
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_brp__alloc_and_store
wmi_brp__alloc_and_store:
	.global L_8db598
L_8db598:
	push_s blink
L_8db59a:
	bl L_8c01e0
L_8db59e:
	mov_s r14,r0
L_8db5a0:
	mov_s r13,r1
L_8db5a2:
	bl.d L_8c3284
L_8db5a6:
	mov_s r15,r2
L_8db5a8:
	stb_s r14,[r0]
L_8db5aa:
	stb_s r13,[r0,0x1]
L_8db5ac:
	stb_s r15,[r0,0x2]
L_8db5ae:
	mov_s r1,0x32
L_8db5b0:
	mov_s r2,0x3
L_8db5b2:
	bl.d L_8e5204
L_8db5b6:
	mov_s r3,0x0
L_8db5b8:
	b L_8c024c
