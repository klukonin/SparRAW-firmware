/* conn__alloc_and_link @ 0x8e5258, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__alloc_and_link__thunk_0_1_0, conn__alloc_and_link_kind1, wmi_pcp_start_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__alloc_and_link
conn__alloc_and_link:
	.global L_8e5258
L_8e5258:
	push_s blink
L_8e525a:
	bl L_8c01e0
L_8e525e:
	mov_s r14,r1
L_8e5260:
	bl.d L_8c3284
L_8e5264:
	mov_s r15,r2
L_8e5266:
	mov_s r13,r0
L_8e5268:
	bl.d L_8cc3dc
L_8e526c:
	mov_s r0,r15
L_8e526e:
	ld_s r0,[r0,0x50]
L_8e5270:
	stb_s r14,[r13,0x1]
L_8e5272:
	stb_s r0,[r13]
L_8e5274:
	mov_s r0,r13
L_8e5276:
	mov_s r1,0x1b
L_8e5278:
	mov_s r2,0x3
L_8e527a:
	bl.d L_8e5204
L_8e527e:
	mov_s r3,0x0
L_8e5280:
	b L_8c024c
