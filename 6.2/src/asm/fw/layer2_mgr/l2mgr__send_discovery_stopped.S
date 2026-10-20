/* l2mgr__send_discovery_stopped @ 0x8f8904, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCOVERY_STOPPED_EVENTID for midid %d.
 * Зовут его: find_sm__stop_discovery
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, host_if__send_pair, l2_mgr__chk_sys_idle, low_sme__send_evt2sw, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_discovery_stopped
l2mgr__send_discovery_stopped:
	.global L_8f8904
L_8f8904:
	push_s blink
L_8f8906:
	push_s r13
L_8f8908:
	bl.d L_8c6508
L_8f890c:
	mov_s r13,r0
L_8f890e:
	mov_s r0,0x10
L_8f8910:
	bl.d L_8e8a14
L_8f8914:
	mov_s r1,0x0
L_8f8916:
	mov_s r1,0x100ec50
L_8f891c:
	mov_s r0,0x2b
L_8f891e:
	bl.d L_8dcc10
L_8f8922:
	mov_s r2,r13
L_8f8924:
	bl L_8c32d8
L_8f8928:
	mov_s r1,0x1917
L_8f892e:
	mov_s r2,0x0
L_8f8930:
	mov_s r3,r13
L_8f8932:
	mov r4,0x0
L_8f8936:
	mov r5,0x0
L_8f893a:
	bl.d L_8e5474
L_8f893e:
	mov r6,0x0
L_8f8942:
	b L_8c025c
L_8f8946:
	nop_s
