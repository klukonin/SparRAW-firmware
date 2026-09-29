/* mac_hdr__copy_addr @ 0x8cc3ac, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_mac_header, tx_send_packet_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_hdr__copy_addr
mac_hdr__copy_addr:
	.global L_8cc3ac
L_8cc3ac:
	mov_s r2,r0
L_8cc3ae:
	mov_s r0,r1
L_8cc3b0:
	add r1,r2,0xa
L_8cc3b4:
	b.d L_8c0380
L_8cc3b8:
	mov_s r2,0x6
L_8cc3ba:
	nop_s
