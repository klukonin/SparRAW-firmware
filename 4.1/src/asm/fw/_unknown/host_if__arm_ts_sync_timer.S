/* host_if__arm_ts_sync_timer @ 0x8dc824, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__timestamp_sync
 * Зовёт сам: l2mgr__arm_notify_timer
 */
	.section .text.host_if__arm_ts_sync_timer,"ax",@progbits
	.global host_if__arm_ts_sync_timer
host_if__arm_ts_sync_timer:
	.global L_8dc824
L_8dc824:
	st_s r1,[r0,0x3c]
L_8dc826:
	mov_s r1,0x1
L_8dc828:
	b.d L_8dfbe8
