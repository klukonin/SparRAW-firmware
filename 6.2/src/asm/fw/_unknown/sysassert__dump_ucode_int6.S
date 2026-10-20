/* sysassert__dump_ucode_int6 @ 0x8c9ce0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ucode WatchDog!!!!!
 *   FA rates: previous=%d[FA/ms] current=%d[FA/ms]
 *   uCode INT6 additional info: MAC_SXD.MAC_HW_ICR 0x%08x
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sysassert__dump_ucode_int6
sysassert__dump_ucode_int6:
	.global L_8c9ce0
L_8c9ce0:
	push_s blink
L_8c9ce2:
	push_s r13
L_8c9ce4:
	mov_s r13,0x857000
L_8c9cea:
	ld_s r0,[r13,0x14]
L_8c9cec:
	breq r0,0x26,L_8c9d12
L_8c9cf0:
	brne r0,0x29,L_8c9d26
L_8c9cf4:
	mov_s r1,0x1001440
L_8c9cfa:
	bl.d L_8dcba8
L_8c9cfe:
	mov_s r0,0x0
L_8c9d00:
	ld_s r2,[r13,0x1c]
L_8c9d02:
	mov_s r1,0x1001454
L_8c9d08:
	mov_s r0,0x0
L_8c9d0a:
	bl.d L_8dcc80
L_8c9d0e:
	ld_s r3,[r13,0x20]
L_8c9d10:
	b_s L_8c9d26
	.global L_8c9d12
L_8c9d12:
	mov_s r2,0x886e00
L_8c9d18:
	ld_s r2,[r2,0x24]
L_8c9d1a:
	mov_s r1,0x1001484
L_8c9d20:
	bl.d L_8dcc10
L_8c9d24:
	mov_s r0,0x0
	.global L_8c9d26
L_8c9d26:
	b L_8c025c
L_8c9d2a:
	nop_s
