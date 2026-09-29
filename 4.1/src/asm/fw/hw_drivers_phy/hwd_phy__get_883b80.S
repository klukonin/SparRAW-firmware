/* hwd_phy__get_883b80 @ 0x8cfed8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_resp
 * Зовёт сам: bitmask_below
 */
	.section .text.hwd_phy__get_883b80,"ax",@progbits
	.global hwd_phy__get_883b80
hwd_phy__get_883b80:
	.global L_8cfed8
L_8cfed8:
	push_s blink
L_8cfeda:
	mov_s r0,0x883b80
L_8cfee0:
	ld_s r0,[r0,0x6c]
L_8cfee2:
	lsr_s r0,r0,0xa
L_8cfee4:
	bmsk_s r0,r0,0xa
L_8cfee6:
	bl.d L_8e55ac
L_8cfeea:
	mov_s r1,0xb
L_8cfeec:
	sexw_s r0,r0
L_8cfeee:
	pop_s blink
L_8cfef0:
	j_s [blink]
L_8cfef2:
	nop_s
