/* radio_mgr__request @ 0x8e0218, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   radio_manager.cpp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.radio_mgr__request,"ax",@progbits
	.global radio_mgr__request
radio_mgr__request:
L_8e0218:
	add_s sp,sp,0x4c
	.global sub_8e021a
sub_8e021a:
L_8e021a:
	nop_s
L_8e021c:
	push_s blink
L_8e021e:
	bl L_8c02b0
L_8e0222:
	mov_s r14,r0
L_8e0224:
	mov_s r15,r1
L_8e0226:
	mov_s r16,r2
L_8e0228:
	mov.f r13,r3
L_8e022c:
	mov r19,r4
L_8e0230:
	mov r17,r5
L_8e0234:
	mov r18,r6
L_8e0238:
	beq_s L_8e0260
	.global L_8e023a
L_8e023a:
	st r19,[r13, 0x1c]
L_8e023e:
	st r17,[r13, 0x18]
L_8e0242:
	st_s r15,[r13,0xc]
L_8e0244:
	st r16,[r13, 0x10]
L_8e0248:
	stb r18,[r13, 0x20]
L_8e024c:
	add r0,r14,0x28
L_8e0250:
	mov_s r1,0xa
L_8e0252:
	mov_s r2,r13
L_8e0254:
	mov_s r3,0x0
L_8e0256:
	bl.d L_8d6a1c
L_8e025a:
	mov_s r4,r3
L_8e025c:
	b L_8c030c
	.global L_8e0260
L_8e0260:
	mov_s r0,blink
L_8e0262:
	mov_s r2,0x1015cc4
L_8e0268:
	mov_s r1,0x8b
L_8e026a:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8e026c:
	bl.d L_8c82c0
L_8e0270:
	mov_s r3,0x47
L_8e0272:
	b_s L_8e023a
