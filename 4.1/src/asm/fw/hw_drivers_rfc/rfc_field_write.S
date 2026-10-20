/* rfc_field_write @ 0x8d113c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, rf_sector_params_write, rfc__write_chain_field, rfc__write_field_1136, rfc__write_field_484, rfc__write_packed_fields
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, hwd_rfc_write_core
 */
	.section .text.rfc_field_write,"ax",@progbits
	.global rfc_field_write
rfc_field_write:
	.global L_8d113c
L_8d113c:
	push_s blink
L_8d113e:
	bl L_8c02b8
L_8d1142:
	mov_s r16,r1
L_8d1144:
	cmp_s r1,0x7fff
L_8d114a:
	mov_s r17,r2
L_8d114c:
	bhi_s L_8d115e
	.global L_8d114e
L_8d114e:
	mov_s r0,0x0
L_8d1150:
	mov_s r1,r0
L_8d1152:
	mov_s r2,r16
L_8d1154:
	bl.d L_8d0f80
L_8d1158:
	mov_s r3,r17
L_8d115a:
	b L_8c031c
	.global L_8d115e
L_8d115e:
	mov_s r0,blink
L_8d1160:
	mov_s r2,0x1018f58
L_8d1166:
	mov_s r1,0x1142
L_8d116c:
	bl.d L_8c82c0
L_8d1170:
	mov_s r3,0x80
L_8d1172:
	b_s L_8d114e
