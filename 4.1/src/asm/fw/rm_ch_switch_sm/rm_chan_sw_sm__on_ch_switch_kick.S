/* rm_chan_sw_sm__on_ch_switch_kick @ 0x8c4de0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, tx_api__pause_for_ch_switch
 */
	.section .text.rm_chan_sw_sm__on_ch_switch_kick,"ax",@progbits
	.global rm_chan_sw_sm__on_ch_switch_kick
rm_chan_sw_sm__on_ch_switch_kick:
L_8c4de0:
	push_s blink
L_8c4de2:
	bl L_8c02c4
L_8c4de6:
	mov.f r14,r1
L_8c4dea:
	mov_s r13,r0
L_8c4dec:
	beq_s L_8c4e0a
	.global L_8c4dee
L_8c4dee:
	st 0xffff,[r13, 0x3c]
L_8c4df6:
	mov_s r0,0x0
L_8c4df8:
	st_s r0,[r13,0x34]
L_8c4dfa:
	st_s r0,[r13,0x38]
L_8c4dfc:
	st_s r14,[r13,0x30]
L_8c4dfe:
	mov_s r0,0x5
L_8c4e00:
	bl.d L_8e2e30
L_8c4e04:
	st_s r0,[r13,0x34]
L_8c4e06:
	b L_8c0334
	.global L_8c4e0a
L_8c4e0a:
	mov_s r0,blink
L_8c4e0c:
	mov_s r2,0x1016114
L_8c4e12:
	mov_s r1,0x116b
L_8c4e18:
	bl.d L_8c82c0
L_8c4e1c:
	mov_s r3,0x79
L_8c4e1e:
	b_s L_8c4dee
