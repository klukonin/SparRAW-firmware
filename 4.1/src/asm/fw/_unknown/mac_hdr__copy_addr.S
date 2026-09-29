/* mac_hdr__copy_addr @ 0x8ca180, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_mac_header, tx_send_packet_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.mac_hdr__copy_addr,"ax",@progbits
	.global mac_hdr__copy_addr
mac_hdr__copy_addr:
	.global L_8ca180
L_8ca180:
	mov_s r2,r0
L_8ca182:
	mov_s r0,r1
L_8ca184:
	add r1,r2,0xa
L_8ca188:
	b.d L_8c0460
L_8ca18c:
	mov_s r2,0x6
L_8ca18e:
	nop_s
