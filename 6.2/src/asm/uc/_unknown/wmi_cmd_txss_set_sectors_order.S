/* wmi_cmd_txss_set_sectors_order @ 0x93e1c0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_cmd_txss_set_sectors_order: Enter, sta_id = %d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_uc, uc_log__emit1, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global wmi_cmd_txss_set_sectors_order
wmi_cmd_txss_set_sectors_order:
	.global L_93e1c0
L_93e1c0:
	push_s blink
L_93e1c2:
	bl L_920234
L_93e1c6:
	mov_s r14,r0
L_93e1c8:
	ld_s r0,[r0,0x4c]
L_93e1ca:
	breq r0,0x1,L_93e1fc
L_93e1ce:
	mov_s r1,0x10019d0
L_93e1d4:
	add3 r13,r14,0x8
L_93e1d8:
	mov_s r0,0x20
L_93e1da:
	bl.d L_92d1d0
L_93e1de:
	ldb_s r2,[r13,0x10]
L_93e1e0:
	ldb_s r0,[r13,0x10]
L_93e1e2:
	brge r0,0x9,L_93e200
	.global L_93e1e6
L_93e1e6:
	ldb_s r0,[r13,0x10]
L_93e1e8:
	mov_s r1,r14
L_93e1ea:
	mul64 r0,0x4c
L_93e1ee:
	add r0,mlo,0x802b68
L_93e1f6:
	bl.d L_920330
L_93e1fa:
	mov_s r2,0x4c
	.global L_93e1fc
L_93e1fc:
	b L_9202a4
	.global L_93e200
L_93e200:
	mov_s r0,blink
L_93e202:
	mov_s r1,0x136c
L_93e208:
	bl L_926618
L_93e20c:
	b_s L_93e1e6
L_93e20e:
	nop_s
