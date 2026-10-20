/* PS_CONNECTION__assoc_ntf @ 0x8c3308, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::assoc_ntf (conn_p=0x%x, is_psm_enabled=%d)
 * Зовут его: ps_connection_mgr__on_assoc
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__inject_event, fw_log__emit2, ps_mode_sm__init, psc_if__init
 */
	.section .text.PS_CONNECTION__assoc_ntf,"ax",@progbits
	.global PS_CONNECTION__assoc_ntf
PS_CONNECTION__assoc_ntf:
	.global L_8c3308
L_8c3308:
	push_s blink
L_8c330a:
	bl L_8c02bc
L_8c330e:
	mov_s r14,r0
L_8c3310:
	mov_s r13,r1
L_8c3312:
	mov_s r16,r2
L_8c3314:
	mov_s r2,0x10028c8
L_8c331a:
	mov_s r0,0xe
L_8c331c:
	mov_s r1,0x2
L_8c331e:
	mov_s r3,r13
L_8c3320:
	bl.d L_8edff8
L_8c3324:
	mov r4,r16
L_8c3328:
	st_s r13,[r14,0x58]
L_8c332a:
	st r16,[r14]
L_8c332e:
	add2 r15,r14,0x17
L_8c3332:
	mov_s r0,r15
L_8c3334:
	mov_s r1,r14
L_8c3336:
	bl.d L_8d632c
L_8c333a:
	mov_s r2,r13
L_8c333c:
	ld_s r2,[r13,0xc]
L_8c333e:
	add_s r13,r14,0x4
L_8c3340:
	mov_s r0,r13
L_8c3342:
	mov_s r1,r15
L_8c3344:
	bl.d L_8d596c
L_8c3348:
	ldb_s r2,[r2,0x10]
L_8c334a:
	mov_s r1,0x0
L_8c334c:
	stb r1,[r14, 0x38]
L_8c3350:
	stb r1,[r14, 0x39]
L_8c3354:
	st_s r1,[r14,0x3c]
L_8c3356:
	stb r1,[r14, 0x48]
L_8c335a:
	st_s r1,[r14,0x4c]
L_8c335c:
	mov_s r0,0x801a04
L_8c3362:
	ld_s r2,[r0]
L_8c3364:
	ld_s r0,[r0,0x4]
L_8c3366:
	st_s r2,[r14,0x40]
L_8c3368:
	st_s r0,[r14,0x44]
L_8c336a:
	st_s r0,[r14,0x54]
L_8c336c:
	ld_s r0,[r14]
L_8c336e:
	st_s r2,[r14,0x50]
L_8c3370:
	cmp_s r0,0x0
L_8c3372:
	mov.ne r0,r13
L_8c3376:
	mov.ne r2,r1
L_8c337a:
	mov.ne r3,r1
L_8c337e:
	bl.ne.d L_8d6a1c
L_8c3382:
	mov.ne r4,r1
L_8c3386:
	.byte 0xa1,0x07
