/* lmac_if_send_cmd_0x30 @ 0x8db7f8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_force_mcs
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x30
lmac_if_send_cmd_0x30:
	.global L_8db7f8
L_8db7f8:
	push_s blink
L_8db7fa:
	bl L_8c01e0
L_8db7fe:
	mov_s r14,r0
L_8db800:
	mov_s r13,r1
L_8db802:
	bl.d L_8c3284
L_8db806:
	mov_s r15,r2
L_8db808:
	stb_s r14,[r0]
L_8db80a:
	stb_s r13,[r0,0x1]
L_8db80c:
	stb_s r15,[r0,0x2]
L_8db80e:
	mov_s r1,0x30
L_8db810:
	mov_s r2,0x3
L_8db812:
	bl.d L_8e5204
L_8db816:
	mov_s r3,0x0
L_8db818:
	b L_8c024c
