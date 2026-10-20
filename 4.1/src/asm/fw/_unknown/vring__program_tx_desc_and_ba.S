/* vring__program_tx_desc_and_ba @ 0x8c5e88, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__program_assoc_vring, mid__setup_bcast_vring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, tx_dma__build_desc
 */
	.section .text.vring__program_tx_desc_and_ba,"ax",@progbits
	.global vring__program_tx_desc_and_ba
vring__program_tx_desc_and_ba:
	.global L_8c5e88
L_8c5e88:
	push_s blink
L_8c5e8a:
	bl.d L_8c02c4
L_8c5e8e:
	mov r6,r4
L_8c5e92:
	sub_s sp,sp,0x10
L_8c5e94:
	mov_s r14,r0
L_8c5e96:
	mov_s r13,sp
L_8c5e98:
	mov_s r0,r13
L_8c5e9a:
	bl.d L_8e4f58
L_8c5e9e:
	mov r4,0x0
L_8c5ea2:
	mov_s r0,r13
L_8c5ea4:
	ldb_s r1,[r14]
L_8c5ea6:
	mov_s r2,0x2
L_8c5ea8:
	mov_s r3,0x0
L_8c5eaa:
	mov r4,0x0
L_8c5eae:
	mov r5,r4
L_8c5eb2:
	mov r6,0x3
L_8c5eb6:
	bl.d L_8c46a4
L_8c5eba:
	mov r7,0x1
L_8c5ebe:
	b.d L_8c0334
L_8c5ec2:
	add_s sp,sp,0x10
