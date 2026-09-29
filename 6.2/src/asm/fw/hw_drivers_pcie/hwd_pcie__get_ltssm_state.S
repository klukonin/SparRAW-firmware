/* hwd_pcie__get_ltssm_state @ 0x8d13fc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie__is_l1_state, link_lost_diag__dump_pcie
 * Зовёт сам: hwd_pcie__is_ep_under_serdes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__get_ltssm_state
hwd_pcie__get_ltssm_state:
	.global L_8d13fc
L_8d13fc:
	push_s blink
L_8d13fe:
	bl L_8d1470
L_8d1402:
	breq_s r0,0,L_8d140e
L_8d1404:
	mov_s r0,0x882580
L_8d140a:
	ld_s r0,[r0,0xc]
L_8d140c:
	b_s L_8d1416
	.global L_8d140e
L_8d140e:
	mov_s r0,0x882080
L_8d1414:
	ld_s r0,[r0,0x40]
	.global L_8d1416
L_8d1416:
	bmsk_s r0,r0,0x4
L_8d1418:
	pop_s blink
L_8d141a:
	j_s [blink]
