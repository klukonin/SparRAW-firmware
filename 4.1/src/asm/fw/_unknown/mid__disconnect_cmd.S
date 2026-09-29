/* mid__disconnect_cmd @ 0x8c7c3c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MID#%d:: Disconnection cmd for CID %d,  reason %d.
 * Зовут его: l2mgr__disconnect_sta, mid_list__disconnect_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log__emit3
 */
	.section .text.mid__disconnect_cmd,"ax",@progbits
	.global mid__disconnect_cmd
mid__disconnect_cmd:
	.global L_8c7c3c
L_8c7c3c:
	push_s blink
L_8c7c3e:
	bl L_8c02bc
L_8c7c42:
	mov_s r14,r0
L_8c7c44:
	mov_s r13,r1
L_8c7c46:
	ldb.a r0,[r1,0xb0]
L_8c7c4a:
	mov_s r16,r2
L_8c7c4c:
	mov_s r15,r3
L_8c7c4e:
	breq r0,0x2,L_8c7c56
L_8c7c52:
	ld_s r0,[r1,0x30]
L_8c7c54:
	breq_s r0,0,L_8c7c7a
	.global L_8c7c56
L_8c7c56:
	ldb r4,[r13, 0x8]
L_8c7c5a:
	mov_s r2,0x100b700
L_8c7c60:
	ldb_s r3,[r14,0x10]
L_8c7c62:
	mov_s r0,0xb
L_8c7c64:
	mov_s r1,0x2
L_8c7c66:
	bl.d L_8ee034
L_8c7c6a:
	mov_s r5,r15
L_8c7c6c:
	mov_s r0,r13
L_8c7c6e:
	mov_s r1,r16
L_8c7c70:
	bl.d L_8eb190
L_8c7c74:
	mov_s r2,r15
L_8c7c76:
	mov_s r0,0x1
L_8c7c78:
	b_s L_8c7c7c
	.global L_8c7c7a
L_8c7c7a:
	mov_s r0,0x0
	.global L_8c7c7c
L_8c7c7c:
	b L_8c0324
