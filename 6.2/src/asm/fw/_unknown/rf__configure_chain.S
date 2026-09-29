/* rf__configure_chain @ 0x8d705c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_exit, init_rf_hw, rf__restore_if_needed
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_abif__uses_rgf_889380, hwd_rfc_write_core_fw_mode1, rfc__write_chain_field, rfc__write_packed_fields
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__configure_chain
rf__configure_chain:
	.global L_8d705c
L_8d705c:
	push_s blink
L_8d705e:
	bl.d L_8c01dc
L_8d7062:
	mov_s r2,0x0
L_8d7064:
	mov_s r16,r0
L_8d7066:
	mov_s r13,r1
L_8d7068:
	mov_s r1,0x1
L_8d706a:
	bl.d L_8d3e58
L_8d706e:
	mov_s r3,r2
L_8d7070:
	brne_s r13,0,L_8d70aa
	.global L_8d7072
L_8d7072:
	cmp_s r13,0x0
L_8d7074:
	mov.ne r13,0x1
L_8d7078:
	add r5,r13,0xa
L_8d707c:
	extb r5,r5
L_8d7080:
	mov_s r0,r16
L_8d7082:
	mov_s r1,0x1
L_8d7084:
	mov_s r2,0x2
L_8d7086:
	mov_s r3,0x7
L_8d7088:
	mov_s r4,r3
L_8d708a:
	mov_s r6,r1
L_8d708c:
	bl.d L_8d3e80
L_8d7090:
	mov_s r7,r1
L_8d7092:
	mov_s r0,0x47974700
L_8d7098:
	bl.d L_8d0098
L_8d709c:
	mov_s r1,0x17
L_8d709e:
	bl.d L_8d33ec
L_8d70a2:
	mov_s r0,0x0
L_8d70a4:
	b.d L_8c0244
L_8d70a8:
	mov_s r0,0x1
	.global L_8d70aa
L_8d70aa:
	mov_s r0,blink
L_8d70ac:
	mov_s r1,0x1462
L_8d70b2:
	bl L_8c9b28
L_8d70b6:
	b_s L_8d7072
