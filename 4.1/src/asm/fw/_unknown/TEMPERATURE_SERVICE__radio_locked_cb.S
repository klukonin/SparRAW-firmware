/* TEMPERATURE_SERVICE__radio_locked_cb @ 0x8ddc7c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::radio_locked_cb() m_temp_enabled = FALSE - unlocking radio 0x%x
 *   TEMPERATURE_SERVICE::radio_locked_cb() m_service_stopping = TRUE - unlocking radio 0x%x
 *   Temperatures: BaseBand=%d[mili-Celcius] RF=%d[mili-Celcius] <ts: %d>
 *   TEMPERATURE_SERVICE::radio_locked_cb() - unlocking radio 0x%x
 * Зовёт сам: RADIO_MGR__unlock, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_log__emit3, fw_read_timer, perform_first_measurement_operations, temp_sense__reschedule_timer, temp_service__sample_without_rf
 * Глобалы (через gp): 0x800368
 */
	.section .text.TEMPERATURE_SERVICE__radio_locked_cb,"ax",@progbits
	.global TEMPERATURE_SERVICE__radio_locked_cb
TEMPERATURE_SERVICE__radio_locked_cb:
L_8ddc7c:
	push_s blink
L_8ddc7e:
	bl L_8c02c0
L_8ddc82:
	mov_s r14,r0
L_8ddc84:
	ld_s r0,[gp,-0x4]
L_8ddc86:
	brne_s r0,0,L_8ddca6
L_8ddc88:
	mov_s r2,0x100ff00
L_8ddc8e:
	mov_s r0,0xc
L_8ddc90:
	mov_s r1,0x1
L_8ddc92:
	bl.d L_8edfcc
L_8ddc96:
	mov_s r3,r14
L_8ddc98:
	bl.d L_8e54d8
L_8ddc9c:
	mov_s r0,r14
L_8ddc9e:
	mov_s r0,0x0
L_8ddca0:
	st.as r0,[gp,-0xe]
L_8ddca4:
	b_s L_8ddd34
	.global L_8ddca6
L_8ddca6:
	ld_s r0,[gp,-0x24]
L_8ddca8:
	brne r0,0x1,L_8ddcce
L_8ddcac:
	mov_s r2,0x100ff58
L_8ddcb2:
	mov_s r0,0xc
L_8ddcb4:
	mov_s r1,0x2
L_8ddcb6:
	bl.d L_8edfcc
L_8ddcba:
	mov_s r3,r14
L_8ddcbc:
	bl.d L_8e54d8
L_8ddcc0:
	mov_s r0,r14
L_8ddcc2:
	mov_s r0,0x0
L_8ddcc4:
	st.as r0,[gp,-0x9]
L_8ddcc8:
	st.as r0,[gp,-0xe]
L_8ddccc:
	b_s L_8ddd34
	.global L_8ddcce
L_8ddcce:
	bl L_8e4694
L_8ddcd2:
	bl.d L_8ddfa4
L_8ddcd6:
	mov_s r15,r0
L_8ddcd8:
	ld.as r4,[gp,-0xd]
L_8ddcdc:
	mov_s r2,0x100ffb0
L_8ddce2:
	ld.as r3,[gp,-0x34]
L_8ddce6:
	mov_s r0,0x6
L_8ddce8:
	mov_s r1,0x2
L_8ddcea:
	bl.d L_8ee034
L_8ddcee:
	mov_s r5,r15
L_8ddcf0:
	mov_s r2,0x100fff8
L_8ddcf6:
	mov_s r0,0xc
L_8ddcf8:
	mov_s r1,0x2
L_8ddcfa:
	bl.d L_8edfcc
L_8ddcfe:
	mov_s r3,r14
L_8ddd00:
	ld_s r0,[gp,0x1f8]
L_8ddd02:
	cmp_s r0,0x0
L_8ddd04:
	bl.eq L_8dc6f4
L_8ddd08:
	bl.d L_8e54d8
L_8ddd0c:
	mov_s r0,r14
L_8ddd0e:
	ld.as r3,[gp,-0x33]
L_8ddd12:
	mov_s r13,0x0
L_8ddd14:
	st.as r13,[gp,-0xe]
L_8ddd18:
	breq_s r3,0,L_8ddd2e
L_8ddd1a:
	ld_s r0,[gp,-0xd0]
L_8ddd1c:
	ld.as r1,[gp,-0xd]
L_8ddd20:
	jl_s.d [r3]
L_8ddd22:
	ld.as r2,[gp,-0x32]
L_8ddd26:
	st.as r13,[gp,-0x33]
L_8ddd2a:
	st.as r13,[gp,-0x32]
	.global L_8ddd2e
L_8ddd2e:
	bl.d L_8dfc98
L_8ddd32:
	ld_s r0,[gp,-0x144]
	.global L_8ddd34
L_8ddd34:
	b L_8c032c
