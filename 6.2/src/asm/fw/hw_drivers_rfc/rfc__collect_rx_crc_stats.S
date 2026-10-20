/* rfc__collect_rx_crc_stats @ 0x8d4010, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, hwm_analog_select_active_rf_module, mdm_stt_rx_crc_ok, rf__get_connected_mask
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__collect_rx_crc_stats
rfc__collect_rx_crc_stats:
	.global L_8d4010
L_8d4010:
	push_s blink
L_8d4012:
	bl L_8c01d4
L_8d4016:
	mov_s r18,r0
L_8d4018:
	mov_s r17,r1
L_8d401a:
	mov_s r15,0x8042c8
L_8d4020:
	bl.d L_8ccb38
L_8d4024:
	mov_s r0,r15
L_8d4026:
	mov_s r16,r0
L_8d4028:
	mov_s r14,0x0
L_8d402a:
	b_s L_8d405c
	.global L_8d402c
L_8d402c:
	mov_s r1,0x0
L_8d402e:
	bset r1,r1,r14
L_8d4032:
	extb_s r1,r1
L_8d4034:
	and r0,r16,r18
L_8d4038:
	tst_s r0,r1
L_8d403a:
	beq_s L_8d405a
L_8d403c:
	bl.d L_8d7584
L_8d4040:
	mov_s r0,r1
L_8d4042:
	mov_s r0,0x8019cc
L_8d4048:
	ld.as r0,[r0,r14]
L_8d404c:
	add3 r13,r17,r14
L_8d4050:
	st_s r0,[r13]
L_8d4052:
	bl.d L_8caeac
L_8d4056:
	mov_s r0,r15
L_8d4058:
	st_s r0,[r13,0x4]
	.global L_8d405a
L_8d405a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d405c
L_8d405c:
	brlt r14,0x8,L_8d402c
L_8d4060:
	b L_8c0234
