/* sm__defer_call @ 0x8e7044, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_frag_done, calib_engine__on_ready_for_correction, calib_engine__on_start, conn_main_sm__action_8c3c60, conn_main_sm__action_8c475c, conn_main_sm__linkup_ntf, conn_msm__on_own_start_link__ready_for_assoc, lm_sm__action_8daed8, lm_sm__action_8e11c8, maintain_sm__action_8c48f8
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm__defer_call
sm__defer_call:
	.global L_8e7044
L_8e7044:
	push_s blink
L_8e7046:
	bl L_8c01d0
L_8e704a:
	mov_s r14,r0
L_8e704c:
	mov_s r18,r1
L_8e704e:
	ldb_s r0,[r0,0x2]
L_8e7050:
	mov_s r17,r3
L_8e7052:
	cmp r0,0xff
L_8e7056:
	mov_s r16,r2
L_8e7058:
	mov r19,r4
L_8e705c:
	bne_s L_8e708e
	.global L_8e705e
L_8e705e:
	mov_s r15,0x803cbc
L_8e7064:
	bl.d L_8c354c
L_8e7068:
	mov_s r0,r15
L_8e706a:
	mov.f r13,r0
L_8e706e:
	beq_s L_8e709c
	.global L_8e7070
L_8e7070:
	st r18,[r13]
L_8e7074:
	st r16,[r13, 0x4]
L_8e7078:
	st r17,[r13, 0x8]
L_8e707c:
	st r19,[r13, 0xc]
L_8e7080:
	add r0,r15,0x14
L_8e7084:
	sub_s r13,r13,r0
L_8e7086:
	/* asr_s r13,r13,0x4 */
	.byte 0x44,0xbd
L_8e7088:
	b.d L_8c022c
L_8e708c:
	stb_s r13,[r14,0x2]
	.global L_8e708e
L_8e708e:
	mov_s r0,blink
L_8e7090:
	mov_s r1,0x16a2
L_8e7096:
	bl L_8c9b28
L_8e709a:
	b_s L_8e705e
	.global L_8e709c
L_8e709c:
	mov_s r0,blink
L_8e709e:
	mov_s r1,0x32
L_8e70a0:
	bl.d L_8c9b28
L_8e70a4:
	bset_s r1,r1,0xc
L_8e70a6:
	b_s L_8e7070
