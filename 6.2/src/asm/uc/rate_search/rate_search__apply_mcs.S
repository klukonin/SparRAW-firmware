/* rate_search__apply_mcs @ 0x9300d0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_end, rs_start, sta__apply_rx_sector_and_mcs, txss_init__flow, txss_resp__flow
 * Зовёт сам: mac__set_cid_mcs_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__apply_mcs
rate_search__apply_mcs:
	.global L_9300d0
L_9300d0:
	push_s blink
L_9300d2:
	breq r1,0x8,L_9300e8
L_9300d6:
	mul64 r1,0x2c
L_9300da:
	add r2,mlo,0x80268d
L_9300e2:
	bl.d L_929568
L_9300e6:
	stb_s r0,[r2]
	.global L_9300e8
L_9300e8:
	pop_s blink
L_9300ea:
	j_s [blink]
