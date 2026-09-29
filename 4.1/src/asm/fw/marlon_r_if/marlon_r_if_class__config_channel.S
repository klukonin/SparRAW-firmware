/* marlon_r_if_class__config_channel @ 0x8c6048, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::config_channel - NO RF on current platform!!!
 *   marlon_r_if.cpp
 *   marlon_r_if_class::config_channel. Loading RX Section for channel %d
 *   marlon_r_if_class::config_channel: Failed to load board file RX Section for channel %d
 *   marlon_r_if_class::config_channel. Loading TX Section for channel %d
 *   marlon_r_if_class::config_channel: Failed to load board file TX Section for channel %d
 *   marlon_r_if_class::config_channel(): m_current_channel_id was set to %d
 * Зовут его: hwm_analog_channel_switch, power_deep_sleep_exit_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, marlon_r_if_class__config_brp_sectors, marlon_r_if_class__load_brd_rf_cfg_section, rf__is_present
 */
	.section .text.marlon_r_if_class__config_channel,"ax",@progbits
	.global marlon_r_if_class__config_channel
marlon_r_if_class__config_channel:
	.global L_8c6048
L_8c6048:
	push_s blink
L_8c604a:
	bl L_8c02bc
L_8c604e:
	mov_s r14,r0
L_8c6050:
	bl.d L_8d750c
L_8c6054:
	mov_s r13,r1
L_8c6056:
	brne_s r0,0,L_8c6068
L_8c6058:
	mov_s r2,0x1005df4
L_8c605e:
	mov_s r0,0x0
L_8c6060:
	bl.d L_8edfb0
L_8c6064:
	mov_s r1,0x1
L_8c6066:
	b_s L_8c60f6
	.global L_8c6068
L_8c6068:
	brlo r13,0x4,L_8c6082
L_8c606c:
	mov_s r0,blink
L_8c606e:
	mov_s r2,0x1005078
L_8c6074:
	mov_s r1,0x119b
L_8c607a:
	bl.d L_8c82c0
L_8c607e:
	mov r3,0x3d2
	.global L_8c6082
L_8c6082:
	bl.d L_8c5f18
L_8c6086:
	mov_s r0,r14
L_8c6088:
	mov_s r2,0x1005e38
L_8c608e:
	add_s r15,r13,0x1
L_8c6090:
	mov_s r0,0x0
L_8c6092:
	mov_s r1,0x2
L_8c6094:
	bl.d L_8edfcc
L_8c6098:
	mov_s r3,r15
L_8c609a:
	asl_s r0,r13
L_8c609c:
	add r16,r0,0x2
L_8c60a0:
	mov_s r0,r14
L_8c60a2:
	mov_s r1,r16
L_8c60a4:
	bl.d L_8d90a8
L_8c60a8:
	mov_s r2,0x80
L_8c60aa:
	brne_s r0,0,L_8c60b4
L_8c60ac:
	mov_s r2,0x1005e80
L_8c60b2:
	b_s L_8c60d8
	.global L_8c60b4
L_8c60b4:
	mov_s r2,0x1005ed8
L_8c60ba:
	mov_s r0,0x0
L_8c60bc:
	mov_s r1,0x2
L_8c60be:
	bl.d L_8edfcc
L_8c60c2:
	mov_s r3,r15
L_8c60c4:
	add r1,r16,0x1
L_8c60c8:
	mov_s r0,r14
L_8c60ca:
	bl.d L_8d90a8
L_8c60ce:
	mov_s r2,0x80
L_8c60d0:
	brne_s r0,0,L_8c60e0
L_8c60d2:
	mov_s r2,0x1005f20
	.global L_8c60d8
L_8c60d8:
	mov_s r0,0x0
L_8c60da:
	mov_s r1,r0
L_8c60dc:
	mov_s r3,r15
L_8c60de:
	b_s L_8c60f2
	.global L_8c60e0
L_8c60e0:
	add r14,r14,0x424
L_8c60e4:
	st_s r13,[r14]
L_8c60e6:
	mov_s r2,0x1005f78
L_8c60ec:
	mov_s r0,0x0
L_8c60ee:
	mov_s r1,0x2
L_8c60f0:
	mov_s r3,r13
	.global L_8c60f2
L_8c60f2:
	bl L_8edfcc
	.global L_8c60f6
L_8c60f6:
	b L_8c0324
L_8c60fa:
	nop_s
