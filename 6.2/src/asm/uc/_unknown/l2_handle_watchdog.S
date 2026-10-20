/* l2_handle_watchdog @ 0x92cf90, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** l2_handle_watchdog ilink1:%08x ilink2:%08x
 *   *** l2_handle_watchdog phy_fa_rate:%u txrx_state:%08x-%08x
 * Зовут его: l2_task__entry
 * Зовёт сам: __ld_r13_to_r13_ret, l2_task__kick_mac_events, power_manager__scale_counters_ms, power_mngr__stats_calc_delta, power_mngr__stats_mark_base, uc_log__emit2, uc_log__emit3, uc_read_tsf_lo, uc_sysassert__scan_stack
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l2_handle_watchdog
l2_handle_watchdog:
	.global L_92cf90
L_92cf90:
	push_s blink
L_92cf92:
	bl.d L_92e6c0
L_92cf96:
	push_s r13
L_92cf98:
	mov_s r13,0x857000
L_92cf9e:
	bl.d L_9364c8
L_92cfa2:
	st_s r0,[r13,0x1c]
L_92cfa4:
	bl L_92e6e8
L_92cfa8:
	bl L_92e6c0
L_92cfac:
	mov_s r2,ilink1
L_92cfae:
	st_s r0,[r13,0x20]
L_92cfb0:
	mov_s r3,ilink2
L_92cfb2:
	mov_s r1,0x1000638
L_92cfb8:
	bl.d L_92d27c
L_92cfbc:
	mov_s r0,0x0
L_92cfbe:
	bl L_92e6c0
L_92cfc2:
	ld.as r3,[gp,0x33]
L_92cfc6:
	mov_s r2,r0
L_92cfc8:
	mov_s r1,0x1000668
L_92cfce:
	mov_s r0,0x0
L_92cfd0:
	ld.as r13,[gp,0x34]
L_92cfd4:
	bl.d L_92d338
L_92cfd8:
	mov_s r4,r13
L_92cfda:
	bl.d L_92635c
L_92cfde:
	mov_s r13,0x1
L_92cfe0:
	mov_s r1,0x800748
L_92cfe6:
	ld_s r2,[r1,0xc]
L_92cfe8:
	ld_s r0,[r1,0x4]
L_92cfea:
	sr r2,[r0]
L_92cfee:
	ld_s r0,[r1]
L_92cff0:
	sr 0x0,[r0]
L_92cff8:
	bl L_92cf60
L_92cffc:
	mov_s r0,0x800624
L_92d002:
	bl.d L_9364c8
L_92d006:
	st_s r13,[r0]
L_92d008:
	bl L_92e704
L_92d00c:
	b L_9202ac
