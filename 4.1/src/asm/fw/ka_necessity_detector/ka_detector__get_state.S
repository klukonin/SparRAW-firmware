/* ka_detector__get_state @ 0x8d714c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector.cpp
 * Зовут его: ka_detector__arm, ka_detector__start_service, ka_necessity_detector__start_monitoring, ka_necessity_detector__task
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, ka_detector__is_active
 */
	.section .text.ka_detector__get_state,"ax",@progbits
	.global ka_detector__get_state
ka_detector__get_state:
	.global L_8d714c
L_8d714c:
	push_s blink
L_8d714e:
	push_s r13
L_8d7150:
	bl.d L_8d72b0
L_8d7154:
	mov_s r13,r0
L_8d7156:
	cmp_s r0,0x0
L_8d7158:
	mov_s r0,0x0
L_8d715a:
	beq_s L_8d7186
L_8d715c:
	ldb r0,[r13, 0x30]
L_8d7160:
	brge r0,0x8,L_8d718a
	.global L_8d7164
L_8d7164:
	ldb r1,[r13, 0x30]
L_8d7168:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d716a:
	ld_s r2,[r13,0x34]
L_8d716c:
	add3_s r1,r1,r1
L_8d716e:
	ld_s r1,[r2,r1]
L_8d7170:
	mov_s r0,0x0
L_8d7172:
	bbit0 r1,0x1,L_8d7184
L_8d7176:
	mov_s r1,0x80345c
L_8d717c:
	ld_s r1,[r1,0xc]
L_8d717e:
	cmp_s r1,0x0
L_8d7180:
	mov.eq r0,0x1
	.global L_8d7184
L_8d7184:
	extb_s r0,r0
	.global L_8d7186
L_8d7186:
	b L_8c033c
	.global L_8d718a
L_8d718a:
	mov_s r0,blink
L_8d718c:
	mov_s r2,0x10113b8
L_8d7192:
	mov_s r1,0x147a
L_8d7198:
	bl.d L_8c82c0
L_8d719c:
	mov_s r3,0x31
L_8d719e:
	b_s L_8d7164
