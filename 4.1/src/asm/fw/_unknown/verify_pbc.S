/* verify_pbc @ 0x8e7134, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   verify_pbc: FALSE is_new_vc = %d,is_local_pbc_active %d is_remote_pbc_active= %d
 *   verify_pbc: TRUE is_new_vc = %d,is_local_pbc_active %d is_remote_pbc_active= %d
 * Зовут его: bss_join_verify
 * Зовёт сам: __ld_r13_ret, fw_log__emit3, parse_wilocity_vs__get_flag3
 */
	.section .text.verify_pbc,"ax",@progbits
	.global verify_pbc
verify_pbc:
	.global L_8e7134
L_8e7134:
	push_s blink
L_8e7136:
	push_s r13
L_8e7138:
	mov_s r0,r2
L_8e713a:
	ld r3,[r1, 0xa4]
L_8e713e:
	mov_s r2,0x0
L_8e7140:
	mov.f r13,r3
L_8e7144:
	mov.ne r13,0x1
L_8e7148:
	cmp_s r3,0x0
L_8e714a:
	mov.eq r5,r2
L_8e714e:
	beq_s L_8e715e
L_8e7150:
	add_s r0,r0,0x48
L_8e7152:
	bl.d L_8db7e0
L_8e7156:
	add r1,r1,0xa0
L_8e715a:
	extw r5,r0
	.global L_8e715e
L_8e715e:
	cmp_s r13,0x0
L_8e7160:
	cmp.ne r5,0x0
L_8e7164:
	beq_s L_8e717e
L_8e7166:
	mov_s r2,0x100b034
L_8e716c:
	mov_s r0,0xb
L_8e716e:
	mov_s r1,0x2
L_8e7170:
	mov_s r3,r13
L_8e7172:
	bl.d L_8ee034
L_8e7176:
	mov r4,0x0
L_8e717a:
	mov_s r0,0x0
L_8e717c:
	b_s L_8e7194
	.global L_8e717e
L_8e717e:
	mov_s r2,0x100b088
L_8e7184:
	mov_s r0,0xb
L_8e7186:
	mov_s r1,0x2
L_8e7188:
	mov_s r3,r13
L_8e718a:
	bl.d L_8ee034
L_8e718e:
	mov r4,0x0
L_8e7192:
	mov_s r0,0x1
	.global L_8e7194
L_8e7194:
	b L_8c033c
