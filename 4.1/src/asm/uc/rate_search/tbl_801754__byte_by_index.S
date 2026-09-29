/* tbl_801754__byte_by_index @ 0x92c1ec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp_queue__release_mgmt, mtp_service__dispatch, rx_flow__run, tx_flows__program_mac_tx
 */
	.section .text.tbl_801754__byte_by_index,"ax",@progbits
	.global tbl_801754__byte_by_index
tbl_801754__byte_by_index:
	.global L_92c1ec
L_92c1ec:
	mov_s r1,0x801754
L_92c1f2:
	mul64 r0,0x2c
L_92c1f6:
	j_s.d [blink]
L_92c1f8:
	ldb r0,[r1,mlo]
