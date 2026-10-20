/* l2_mgr__scan_start_log @ 0x8f0134, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Start scan <ts: %d>
 * Зовут его: l2_mgr__wmi_scan_cmd
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_read_timer, scan_mngr__start_scan
 */
	.section .text.l2_mgr__scan_start_log,"ax",@progbits
	.global l2_mgr__scan_start_log
l2_mgr__scan_start_log:
	.global L_8f0134
L_8f0134:
	push_s blink
L_8f0136:
	bl L_8c02c0
L_8f013a:
	mov_s r13,r0
L_8f013c:
	mov_s r15,r1
L_8f013e:
	bl.d L_8e4694
L_8f0142:
	mov_s r14,r2
L_8f0144:
	mov_s r3,r0
L_8f0146:
	mov_s r2,0x10125fc
L_8f014c:
	mov_s r0,0xc
L_8f014e:
	bl.d L_8edfcc
L_8f0152:
	mov_s r1,0x2
L_8f0154:
	ld_s r0,[r13,0x8]
L_8f0156:
	mov_s r1,r15
L_8f0158:
	bl.d L_8f1474
L_8f015c:
	mov_s r2,r14
L_8f015e:
	b L_8c032c
L_8f0162:
	nop_s
