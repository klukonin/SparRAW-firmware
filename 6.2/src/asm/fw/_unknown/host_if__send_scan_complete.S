/* host_if__send_scan_complete @ 0x8ecb94, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SCAN_COMPLETE_EVENTID for devid %d. WMI_SCAN_ABORTED (due to RF-KILL enabled)
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__send_scan_complete
host_if__send_scan_complete:
	.global L_8ecb94
L_8ecb94:
	push_s blink
L_8ecb96:
	bl L_8c01dc
L_8ecb9a:
	mov_s r16,r0
L_8ecb9c:
	mov_s r0,0x7a1200
L_8ecba2:
	mov lp_count,r0
L_8ecba6:
	nop_s
L_8ecba8:
	lp L_8ecbb0
L_8ecbac:
	nop_s
L_8ecbae:
	nop_s
	.global L_8ecbb0
L_8ecbb0:
	bl L_8c32d8
L_8ecbb4:
	mov_s r1,0x1007b40
L_8ecbba:
	mov_s r13,r0
L_8ecbbc:
	mov_s r0,0x2
L_8ecbbe:
	st_s r0,[r13]
L_8ecbc0:
	mov_s r0,0x0
L_8ecbc2:
	bl.d L_8dcc10
L_8ecbc6:
	mov_s r2,r16
L_8ecbc8:
	mov_s r0,r13
L_8ecbca:
	mov_s r1,0xa
L_8ecbcc:
	bset_s r1,r1,0xc
L_8ecbce:
	mov_s r2,0x4
L_8ecbd0:
	mov_s r3,r16
L_8ecbd2:
	mov r4,0x0
L_8ecbd6:
	mov r5,0x0
L_8ecbda:
	bl.d L_8e5474
L_8ecbde:
	mov r6,0x0
L_8ecbe2:
	b L_8c0244
L_8ecbe6:
	nop_s
