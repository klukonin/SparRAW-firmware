/* fr_clr_mdm_crc_statistics @ 0x8c9220, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fr_clr_mdm_crc_statistics: write 1 to mdm_stt_crc_clr
 * Зовут его: rf__identify_type, temp_sense__no_rf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, marlon_r_if__write_reg, tail_hwd_rfc_read_rgf
 */
	.section .text.fr_clr_mdm_crc_statistics,"ax",@progbits
	.global fr_clr_mdm_crc_statistics
fr_clr_mdm_crc_statistics:
	.global L_8c9220
L_8c9220:
	push_s blink
L_8c9222:
	bl.d L_8c02c0
L_8c9226:
	mov_s r1,0x0
L_8c9228:
	mov_s r15,r0
L_8c922a:
	bl.d L_8ddd74
L_8c922e:
	mov r2,0x3e0
L_8c9232:
	mov_s r13,r0
L_8c9234:
	bset r14,r0,0xf
L_8c9238:
	mov_s r2,0x1005088
L_8c923e:
	mov_s r0,0x0
L_8c9240:
	bl.d L_8edfb0
L_8c9244:
	mov_s r1,0x2
L_8c9246:
	mov_s r0,r15
L_8c9248:
	mov_s r1,0x0
L_8c924a:
	mov r2,0x3e0
L_8c924e:
	bl.d L_8e7f60
L_8c9252:
	mov_s r3,r14
L_8c9254:
	mov_s r0,r15
L_8c9256:
	mov_s r1,0x0
L_8c9258:
	mov r2,0x3e0
L_8c925c:
	bl.d L_8e7f60
L_8c9260:
	mov_s r3,r13
L_8c9262:
	b L_8c032c
L_8c9266:
	nop_s
