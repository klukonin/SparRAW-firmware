/* start_find_session @ 0x8f9628, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   start_find_session()
 * Зовут его: l2mgr__start_discovery
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__session_start, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global start_find_session
start_find_session:
	.global L_8f9628
L_8f9628:
	push_s blink
L_8f962a:
	push_s r13
L_8f962c:
	mov_s r13,r0
L_8f962e:
	mov_s r1,0x1016fec
L_8f9634:
	bl.d L_8dcba8
L_8f9638:
	mov_s r0,0x2c
L_8f963a:
	ld_s r0,[r13,0x8]
L_8f963c:
	ld_s r0,[r0,0x78]
L_8f963e:
	brne_s r0,0,L_8f9654
	.global L_8f9640
L_8f9640:
	ld_s r0,[r13,0x4]
L_8f9642:
	ld_s r0,[r0,0x4c]
L_8f9644:
	brne r0,0x1,L_8f9662
	.global L_8f9648
L_8f9648:
	bl.d L_8e7ca0
L_8f964c:
	add r0,r13,0xc
L_8f9650:
	b L_8c025c
	.global L_8f9654
L_8f9654:
	mov_s r0,blink
L_8f9656:
	mov_s r1,0x1235
L_8f965c:
	bl L_8c9b28
L_8f9660:
	b_s L_8f9640
	.global L_8f9662
L_8f9662:
	mov_s r0,blink
L_8f9664:
	mov_s r1,0x1236
L_8f966a:
	bl L_8c9b28
L_8f966e:
	b_s L_8f9648
