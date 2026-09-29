/* l2_task__run @ 0x929bfc, 712 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_task.c
 * Зовут его: l2_task__entry
 * Зовёт сам: __ld_r13_ret_uc, get_g_800724, l2_task__kick_mac_events, power_manager__scale_counters_ms, power_manager__snapshot_marks, power_manager__update_deltas, uc_read_tsf_lo, uc_sysassert
 * Глобалы (через gp): 0x800608
 */
	.section .text.l2_task__run,"ax",@progbits
	.global l2_task__run
l2_task__run:
	.global L_929bfc
L_929bfc:
	push_s blink
L_929bfe:
	bl.d L_92b1c8
L_929c02:
	push_s r13
L_929c04:
	mov_s r13,0x857000
L_929c0a:
	bl.d L_9315e8
L_929c0e:
	st_s r0,[r13,0x30]
L_929c10:
	bl L_92b1f0
L_929c14:
	bl L_92b1c8
L_929c18:
	st_s r0,[r13,0x34]
L_929c1a:
	bl.d L_92b1ac
L_929c1e:
	mov_s r0,0xa
L_929c20:
	breq_s r0,0,L_929c54
L_929c22:
	mov_s r1,0x8006b4
L_929c28:
	ld_s r2,[r1,0xc]
L_929c2a:
	ld_s r0,[r1,0x4]
L_929c2c:
	sr r2,[r0]
L_929c30:
	ld_s r0,[r1]
L_929c32:
	sr 0x0,[r0]
L_929c3a:
	bl.d L_929bcc
L_929c3e:
	mov_s r13,0x1
L_929c40:
	mov_s r0,0x80062c
L_929c46:
	bl.d L_9315e8
L_929c4a:
	st_s r13,[r0]
L_929c4c:
	bl L_92b20c
L_929c50:
	b L_929ebe
	.global L_929c54
L_929c54:
	ld_s r0,[gp,0xe0]
L_929c56:
	mov_s r2,0x10004d8
L_929c5c:
	bbit0 r0,0x0,L_929c6c
L_929c60:
	mov_s r0,blink
L_929c62:
	mov_s r1,0xff
L_929c64:
	asl_s r1,r1,0x8
L_929c66:
	b.d L_929eba
L_929c6a:
	mov_s r3,0xfb
	.global L_929c6c
L_929c6c:
	btst_s r0,0x1
L_929c6e:
	mov.ne r1,0xff01
L_929c76:
	mov.ne r3,0xfe
L_929c7e:
	bne.d L_929eba
L_929c82:
	mov.ne r0,blink
L_929c86:
	btst_s r0,0x2
L_929c88:
	mov.ne r1,0xff02
L_929c90:
	mov.ne r3,0x101
L_929c98:
	bne.d L_929eba
L_929c9c:
	mov.ne r0,blink
L_929ca0:
	btst_s r0,0x3
L_929ca2:
	mov.ne r1,0xff03
L_929caa:
	mov.ne r3,0x104
L_929cb2:
	bne.d L_929eba
L_929cb6:
	mov.ne r0,blink
L_929cba:
	btst_s r0,0x5
L_929cbc:
	mov.ne r1,0xff05
L_929cc4:
	mov.ne r3,0x10c
L_929ccc:
	bne.d L_929eba
L_929cd0:
	mov.ne r0,blink
L_929cd4:
	btst_s r0,0x7
L_929cd6:
	mov.ne r1,0xff07
L_929cde:
	mov.ne r3,0x114
L_929ce6:
	mov.ne r0,blink
L_929cea:
	bne_s L_929eba
L_929cec:
	btst_s r0,0x9
L_929cee:
	mov.ne r1,0xff09
L_929cf6:
	mov.ne r3,0x11c
L_929cfe:
	mov.ne r0,blink
L_929d02:
	bne_s L_929eba
L_929d04:
	btst_s r0,0xa
L_929d06:
	mov.ne r1,0xff10
L_929d0e:
	mov.ne r3,0x11f
L_929d16:
	mov.ne r0,blink
L_929d1a:
	bne_s L_929eba
L_929d1c:
	btst_s r0,0xb
L_929d1e:
	mov.ne r1,0xff11
L_929d26:
	mov.ne r3,0x122
L_929d2e:
	mov.ne r0,blink
L_929d32:
	bne_s L_929eba
L_929d34:
	btst_s r0,0xd
L_929d36:
	mov.ne r1,0xff13
L_929d3e:
	mov.ne r3,0x125
L_929d46:
	mov.ne r0,blink
L_929d4a:
	bne_s L_929eba
L_929d4c:
	btst_s r0,0xe
L_929d4e:
	mov.ne r1,0xff14
L_929d56:
	mov.ne r3,0x128
L_929d5e:
	mov.ne r0,blink
L_929d62:
	bne_s L_929eba
L_929d64:
	btst_s r0,0xf
L_929d66:
	mov.ne r1,0xff15
L_929d6e:
	mov.ne r3,0x12b
L_929d76:
	mov.ne r0,blink
L_929d7a:
	bne_s L_929eba
L_929d7c:
	btst_s r0,0x10
L_929d7e:
	mov.ne r1,0xff16
L_929d86:
	mov.ne r3,0x12e
L_929d8e:
	mov.ne r0,blink
L_929d92:
	bne_s L_929eba
L_929d94:
	btst_s r0,0x11
L_929d96:
	mov.ne r1,0xff17
L_929d9e:
	mov.ne r3,0x131
L_929da6:
	mov.ne r0,blink
L_929daa:
	bne_s L_929eba
L_929dac:
	btst_s r0,0x12
L_929dae:
	mov.ne r1,0xff18
L_929db6:
	mov.ne r3,0x134
L_929dbe:
	mov.ne r0,blink
L_929dc2:
	bne_s L_929eba
L_929dc4:
	btst_s r0,0x13
L_929dc6:
	mov.ne r1,0xff19
L_929dce:
	mov.ne r3,0x137
L_929dd6:
	mov.ne r0,blink
L_929dda:
	bne_s L_929eba
L_929ddc:
	btst_s r0,0x14
L_929dde:
	mov.ne r1,0xff20
L_929de6:
	mov.ne r3,0x13a
L_929dee:
	mov.ne r0,blink
L_929df2:
	bne_s L_929eba
L_929df4:
	btst_s r0,0x15
L_929df6:
	mov.ne r1,0xff21
L_929dfe:
	mov.ne r3,0x13d
L_929e06:
	mov.ne r0,blink
L_929e0a:
	bne_s L_929eba
L_929e0c:
	btst_s r0,0x16
L_929e0e:
	mov.ne r1,0xff22
L_929e16:
	mov.ne r3,0x140
L_929e1e:
	mov.ne r0,blink
L_929e22:
	bne_s L_929eba
L_929e24:
	btst_s r0,0x17
L_929e26:
	mov.ne r1,0xff23
L_929e2e:
	mov.ne r3,0x143
L_929e36:
	mov.ne r0,blink
L_929e3a:
	bne_s L_929eba
L_929e3c:
	btst_s r0,0x1a
L_929e3e:
	mov.ne r1,0xff26
L_929e46:
	mov.ne r3,0x146
L_929e4e:
	mov.ne r0,blink
L_929e52:
	bne_s L_929eba
L_929e54:
	btst_s r0,0x1b
L_929e56:
	mov.ne r1,0xff27
L_929e5e:
	mov.ne r3,0x149
L_929e66:
	mov.ne r0,blink
L_929e6a:
	bne_s L_929eba
L_929e6c:
	btst_s r0,0x1c
L_929e6e:
	mov.ne r1,0xff28
L_929e76:
	mov.ne r3,0x14c
L_929e7e:
	mov.ne r0,blink
L_929e82:
	bne_s L_929eba
L_929e84:
	btst_s r0,0x1d
L_929e86:
	mov.ne r1,0xff29
L_929e8e:
	mov.ne r3,0x14f
L_929e96:
	mov.ne r0,blink
L_929e9a:
	bne_s L_929eba
L_929e9c:
	ld_s r0,[gp,-0xd4]
L_929e9e:
	cmp_s r0,0x0
L_929ea0:
	mov_s r0,blink
L_929ea2:
	mov.ne r1,0xff2a
L_929eaa:
	mov r3,0x152
L_929eae:
	mov.eq r1,0x29
L_929eb2:
	mov.eq r3,0x155
	.global L_929eba
L_929eba:
	bl L_925548
	.global L_929ebe
L_929ebe:
	b L_92028c
L_929ec2:
	nop_s
