/* mlme__free_assoc_buf @ 0x8c5b18, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r13_ret, mgmt_buf__free
 */
	.section .text.mlme__free_assoc_buf,"ax",@progbits
	.global mlme__free_assoc_buf
mlme__free_assoc_buf:
	.global L_8c5b18
L_8c5b18:
	push_s blink
L_8c5b1a:
	push_s r13
L_8c5b1c:
	mov_s r13,r0
L_8c5b1e:
	ld_s r0,[r0,0x48]
L_8c5b20:
	breq_s r0,0,L_8c5b2a
L_8c5b22:
	bl L_8c9538
L_8c5b26:
	mov_s r0,0x0
L_8c5b28:
	st_s r0,[r13,0x48]
	.global L_8c5b2a
L_8c5b2a:
	b L_8c033c
L_8c5b2e:
	nop_s
