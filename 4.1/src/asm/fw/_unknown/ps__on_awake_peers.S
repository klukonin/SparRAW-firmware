/* ps__on_awake_peers @ 0x8edc1c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__awake_peers_evt
 * Зовёт сам: bcon__refresh_dti_ie, mid_list__by_mid
 */
	.section .text.ps__on_awake_peers,"ax",@progbits
	.global ps__on_awake_peers
ps__on_awake_peers:
	.global L_8edc1c
L_8edc1c:
	push_s blink
L_8edc1e:
	bl L_8ca1b0
L_8edc22:
	ld_s r2,[r0,0x50]
L_8edc24:
	mov_s r1,0x0
L_8edc26:
	cmp_s r2,0x2
L_8edc28:
	cmp.ne r2,0x3
L_8edc2c:
	mov.eq r1,0x1
L_8edc30:
	extb.f 0x0,r1
L_8edc34:
	beq_s L_8edc44
L_8edc36:
	mov_s r1,0x857260
L_8edc3c:
	ldb_s r1,[r1,0xc]
L_8edc3e:
	cmp_s r1,0x0
L_8edc40:
	bl.ne L_8e5784
	.global L_8edc44
L_8edc44:
	pop_s blink
L_8edc46:
	j_s [blink]
