/* phy__set_885178_3bit @ 0x8d1b94, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, hwd_phy_rx_read_and_parse_brp_ram
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__set_885178_3bit
phy__set_885178_3bit:
	.global L_8d1b94
L_8d1b94:
	push_s blink
L_8d1b96:
	push_s r13
L_8d1b98:
	mov_s r13,r0
L_8d1b9a:
	bic.f r0,r0,0x7
L_8d1b9e:
	bne_s L_8d1bb4
	.global L_8d1ba0
L_8d1ba0:
	mov_s r1,0x885100
L_8d1ba6:
	ld_s r0,[r1,0x78]
L_8d1ba8:
	bic r0,r0,0x7
L_8d1bac:
	or_s r13,r13,r0
L_8d1bae:
	st_s r13,[r1,0x78]
L_8d1bb0:
	b L_8c025c
	.global L_8d1bb4
L_8d1bb4:
	mov_s r0,blink
L_8d1bb6:
	bl.d L_8c9b28
L_8d1bba:
	mov_s r1,0xac
L_8d1bbc:
	b_s L_8d1ba0
L_8d1bbe:
	nop_s
