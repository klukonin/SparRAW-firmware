/* host_if__send_scan_complete @ 0x8e7ba0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SCAN_COMPLETE_EVENTID for devid %d. WMI_SCAN_ABORTED (due to RF-KILL enabled)
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.host_if__send_scan_complete,"ax",@progbits
	.global host_if__send_scan_complete
host_if__send_scan_complete:
	.global L_8e7ba0
L_8e7ba0:
	push_s blink
L_8e7ba2:
	bl L_8c02bc
L_8e7ba6:
	mov_s r16,r0
L_8e7ba8:
	mov_s r0,0x7a1200
L_8e7bae:
	mov lp_count,r0
L_8e7bb2:
	nop_s
L_8e7bb4:
	lp L_8e7bbc
L_8e7bb8:
	nop_s
L_8e7bba:
	nop_s
	.global L_8e7bbc
L_8e7bbc:
	bl L_8c2b68
L_8e7bc0:
	mov_s r2,0x100715c
L_8e7bc6:
	mov_s r13,r0
L_8e7bc8:
	mov_s r0,0x2
L_8e7bca:
	st_s r0,[r13]
L_8e7bcc:
	mov_s r0,0x0
L_8e7bce:
	mov_s r1,r0
L_8e7bd0:
	bl.d L_8edfcc
L_8e7bd4:
	mov_s r3,r16
L_8e7bd6:
	mov_s r0,r13
L_8e7bd8:
	mov_s r1,0xa
L_8e7bda:
	bset_s r1,r1,0xc
L_8e7bdc:
	mov_s r2,0x4
L_8e7bde:
	mov_s r3,r16
L_8e7be0:
	mov r4,0x0
L_8e7be4:
	bl.d L_8e0874
L_8e7be8:
	mov r5,0x0
L_8e7bec:
	b L_8c0324
