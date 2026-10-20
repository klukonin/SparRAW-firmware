/* rf__get_active_mask @ 0x8ccb1c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_analog_channel_switch, lmac_if__ucode_event_dispatch
 * Глобалы (через gp): 0x800242
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__get_active_mask
rf__get_active_mask:
	.global L_8ccb1c
L_8ccb1c:
	j_s.d [blink]
L_8ccb1e:
	ldb_s r0,[gp,0xbe]
