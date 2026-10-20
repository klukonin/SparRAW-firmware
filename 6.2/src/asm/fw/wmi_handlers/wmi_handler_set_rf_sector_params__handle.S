/* wmi_handler_set_rf_sector_params__handle @ 0x8cd14c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::handle(): Radio is still locked by outdated request m_radio_handle=0x%X, cmd.rf_modules_vec=0x%X, cmd.sector_idx=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3, fw_sysassert_fatal, radio_mgr__request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_set_rf_sector_params__handle
wmi_handler_set_rf_sector_params__handle:
	.global L_8cd14c
L_8cd14c:
	push_s blink
L_8cd14e:
	push_s r13
L_8cd150:
	ld r2,[r0, 0xc8]
L_8cd154:
	mov_s r13,r0
L_8cd156:
	brne_s r2,0,L_8cd176
	.global L_8cd158
L_8cd158:
	mov_s r0,0x1f5f4
L_8cd15e:
	mov_s r1,r13
L_8cd160:
	mov_s r2,0x0
L_8cd162:
	mov_s r3,0xffff
L_8cd168:
	bl.d L_8dcaf4
L_8cd16c:
	mov_s r4,r2
L_8cd16e:
	b.d L_8c025c
L_8cd172:
	st r0,[r13, 0xc8]
	.global L_8cd176
L_8cd176:
	mov_s r1,0x1008434
L_8cd17c:
	ldw r4,[r13]
L_8cd180:
	mov_s r0,0x0
L_8cd182:
	bl.d L_8dcd00
L_8cd186:
	ldb_s r3,[r13,0x3]
L_8cd188:
	mov_s r0,blink
L_8cd18a:
	mov_s r1,0x1468
L_8cd190:
	bl L_8c9b28
L_8cd194:
	b_s L_8cd158
L_8cd196:
	nop_s
