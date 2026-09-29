/* hwd_pcie_dbi_write @ 0x8eab94, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dbi_write FAILED: address=0x%x, data=0x%x, port=%d
 *                     ep_en=%d, shadow_en=%d, shadow_num=%d
 *   hw_drivers_pcie_dbi.c
 * Зовут его: dbi_write_seq, hwd_pcie_l1_sub_timing_config, hwd_pcie_lnkctl_set, pcie__dbi_write_seq, pcie__fix_max_read_req, pcie__force_clear_l0s, pcie__l1_latency_wa
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit3, fw_sysassert_fatal, pcie__dbi_transfer
 */
	.section .text.hwd_pcie_dbi_write,"ax",@progbits
	.global hwd_pcie_dbi_write
hwd_pcie_dbi_write:
	.global L_8eab94
L_8eab94:
	push_s blink
L_8eab96:
	bl L_8c02a8
L_8eab9a:
	sub_s sp,sp,0x4
L_8eab9c:
	mov_s r21,r0
L_8eab9e:
	mov_s r20,r1
L_8eaba0:
	mov_s r19,r2
L_8eaba2:
	mov_s r18,r3
L_8eaba4:
	mov r16,r4
L_8eaba8:
	ldb_s r0,[sp,0x2c]
L_8eabaa:
	mov r17,r5
L_8eabae:
	st_s r0,[sp,0x0]
L_8eabb0:
	bl.d L_8eaae8
L_8eabb4:
	mov_s r0,r21
L_8eabb6:
	mov.f r13,r0
L_8eabba:
	bne_s L_8eabfe
L_8eabbc:
	mov_s r2,0x1018ea4
L_8eabc2:
	mov_s r0,0x0
L_8eabc4:
	mov_s r1,r0
L_8eabc6:
	mov_s r3,r21
L_8eabc8:
	mov r4,r20
L_8eabcc:
	bl.d L_8ee034
L_8eabd0:
	mov r5,r19
L_8eabd4:
	mov_s r2,0x1018ed8
L_8eabda:
	mov_s r0,0x0
L_8eabdc:
	mov_s r1,r0
L_8eabde:
	mov_s r3,r18
L_8eabe0:
	mov r4,r16
L_8eabe4:
	bl.d L_8ee034
L_8eabe8:
	mov r5,r17
L_8eabec:
	mov_s r0,blink
L_8eabee:
	mov_s r2,0x1018f10
L_8eabf4:
	mov_s r1,0xee
L_8eabf6:
	bset_s r1,r1,0xc
L_8eabf8:
	bl.d L_8c82c0
L_8eabfc:
	mov_s r3,0xe2
	.global L_8eabfe
L_8eabfe:
	mov_s r0,r13
L_8eac00:
	b.d L_8c02fc
L_8eac04:
	add_s sp,sp,0x4
L_8eac06:
	nop_s
