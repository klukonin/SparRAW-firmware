/* bss_join_verify @ 0x8c4e80, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bss_join_verify: .................PBC support .....  verify %x
 *   bss_join_verify: .................verify_ssid .....  verify %x
 * Зовут его: mlme_sm__check_assoc_capacity
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, verify_pbc, verify_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bss_join_verify
bss_join_verify:
	.global L_8c4e80
L_8c4e80:
	push_s blink
L_8c4e82:
	bl.d L_8c01e0
L_8c4e86:
	mov_s r2,r3
L_8c4e88:
	mov_s r15,r0
L_8c4e8a:
	bl.d L_8ebd68
L_8c4e8e:
	mov_s r13,r1
L_8c4e90:
	bmsk r14,r0,0x0
L_8c4e94:
	mov_s r1,0x100c658
L_8c4e9a:
	mov_s r0,0x2b
L_8c4e9c:
	bl.d L_8dcc10
L_8c4ea0:
	mov_s r2,r14
L_8c4ea2:
	ld_s r1,[r13,0xc]
L_8c4ea4:
	mov_s r0,r15
L_8c4ea6:
	bl.d L_8ebe18
L_8c4eaa:
	ldb_s r2,[r13,0x9]
L_8c4eac:
	mov_s r13,r0
L_8c4eae:
	mov_s r1,0x100c698
L_8c4eb4:
	mov_s r0,0x2b
L_8c4eb6:
	bl.d L_8dcc10
L_8c4eba:
	and r2,r13,r14
L_8c4ebe:
	b.d L_8c024c
L_8c4ec2:
	and r0,r13,r14
L_8c4ec6:
	nop_s
