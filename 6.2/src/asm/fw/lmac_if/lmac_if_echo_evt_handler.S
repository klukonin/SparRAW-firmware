/* lmac_if_echo_evt_handler @ 0x8db768, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_echo_evt_handler sending deep echo back to SW %x
 * Зовут его: lmac_if__ucode_event_dispatch, vring_schd__resume_vring, vring_schd__stop_vring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, lmac_cmd_pool__alloc, lmac_if__echo_evt_body, lmac_if__echo_pair, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_echo_evt_handler
lmac_if_echo_evt_handler:
	.global L_8db768
L_8db768:
	push_s blink
L_8db76a:
	bl L_8c01e4
L_8db76e:
	bl.d L_8c32e8
L_8db772:
	mov_s r14,r0
L_8db774:
	ld_s r2,[r14]
L_8db776:
	mov_s r13,r0
L_8db778:
	st_s r2,[r0]
L_8db77a:
	mov_s r1,0x1003b8c
L_8db780:
	bl.d L_8dcc10
L_8db784:
	mov_s r0,0x20
L_8db786:
	mov_s r0,r13
L_8db788:
	mov_s r1,0x1803
L_8db78e:
	mov_s r2,0x4
L_8db790:
	bl.d L_8e557c
L_8db794:
	mov_s r3,0x0
L_8db796:
	b L_8c0254
L_8db79a:
	nop_s
	.global L_8db79c
L_8db79c:
	push_s blink
L_8db79e:
	bl L_8c01e4
L_8db7a2:
	mov_s r14,r0
L_8db7a4:
	bl.d L_8c3284
L_8db7a8:
	mov_s r13,r1
L_8db7aa:
	stb_s r14,[r0]
L_8db7ac:
	stb_s r13,[r0,0x1]
L_8db7ae:
	mov_s r1,0x47
L_8db7b0:
	mov_s r2,0x2
L_8db7b2:
	bl.d L_8e5204
L_8db7b6:
	mov_s r3,0x0
L_8db7b8:
	b L_8c0254
