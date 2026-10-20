/* dbi_write @ 0x8c8338, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dbi_write FAILED: address=0x%x, data=0x%x, port=%d
 *                     ep_en=%d, shadow_en=%d, shadow_num=%d
 * Зовут его: hwd_pcie_l1_sub_timing_config, hwd_pcie_lnkctl_set, pcie__dbi_write_seq, pcie__fix_max_read_req, pcie__force_clear_l0s, pcie__l1_latency_wa, pcie_device_power_sm__pcie_traffic_resume_req
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log_emit3, fw_sysassert_fatal, pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dbi_write
dbi_write:
	.global L_8c8338
L_8c8338:
	push_s blink
L_8c833a:
	bl L_8c01c8
L_8c833e:
	sub_s sp,sp,0x4
L_8c8340:
	mov_s r21,r0
L_8c8342:
	mov_s r20,r1
L_8c8344:
	mov_s r19,r2
L_8c8346:
	mov_s r18,r3
L_8c8348:
	mov r16,r4
L_8c834c:
	ldb_s r0,[sp,0x2c]
L_8c834e:
	mov r17,r5
L_8c8352:
	st_s r0,[sp,0x0]
L_8c8354:
	bl.d L_8c828c
L_8c8358:
	mov_s r0,r21
L_8c835a:
	mov.f r13,r0
L_8c835e:
	bne_s L_8c8392
L_8c8360:
	mov_s r1,0x101e054
L_8c8366:
	mov_s r0,0x0
L_8c8368:
	mov_s r2,r21
L_8c836a:
	mov_s r3,r20
L_8c836c:
	bl.d L_8dcd00
L_8c8370:
	mov r4,r19
L_8c8374:
	mov_s r1,0x101e088
L_8c837a:
	mov_s r0,0x0
L_8c837c:
	mov_s r2,r18
L_8c837e:
	mov_s r3,r16
L_8c8380:
	bl.d L_8dcd00
L_8c8384:
	mov r4,r17
L_8c8388:
	mov_s r0,blink
L_8c838a:
	mov_s r1,0xee
L_8c838c:
	bl.d L_8c9b28
L_8c8390:
	bset_s r1,r1,0xc
	.global L_8c8392
L_8c8392:
	mov_s r0,r13
L_8c8394:
	b.d L_8c021c
L_8c8398:
	add_s sp,sp,0x4
L_8c839a:
	nop_s
