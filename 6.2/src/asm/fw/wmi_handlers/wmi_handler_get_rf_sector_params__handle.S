/* wmi_handler_get_rf_sector_params__handle @ 0x8cd104, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::handle(): Radio is still locked by outdated request m_radio_handle=0x%X, cmd.rf_modules_vec=0x%X, cmd.sector_idx=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3, fw_sysassert_fatal, radio_mgr__request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_get_rf_sector_params__handle
wmi_handler_get_rf_sector_params__handle:
	.global L_8cd104
L_8cd104:
	push_s blink
L_8cd106:
	push_s r13
L_8cd108:
	ld_s r2,[r0,0x8]
L_8cd10a:
	mov_s r13,r0
L_8cd10c:
	brne_s r2,0,L_8cd12a
	.global L_8cd10e
L_8cd10e:
	mov_s r0,0x1f5d4
L_8cd114:
	mov_s r1,r13
L_8cd116:
	mov_s r2,0x0
L_8cd118:
	mov_s r3,0xffff
L_8cd11e:
	bl.d L_8dcaf4
L_8cd122:
	mov_s r4,r2
L_8cd124:
	b.d L_8c025c
L_8cd128:
	st_s r0,[r13,0x8]
	.global L_8cd12a
L_8cd12a:
	mov_s r1,0x1007fe8
L_8cd130:
	ldw r4,[r13]
L_8cd134:
	mov_s r0,0x0
L_8cd136:
	bl.d L_8dcd00
L_8cd13a:
	ldb_s r3,[r13,0x3]
L_8cd13c:
	mov_s r0,blink
L_8cd13e:
	mov_s r1,0x1466
L_8cd144:
	bl L_8c9b28
L_8cd148:
	b_s L_8cd10e
L_8cd14a:
	nop_s
