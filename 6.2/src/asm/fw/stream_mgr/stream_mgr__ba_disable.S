/* stream_mgr__ba_disable @ 0x8c4200, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_vring_ba_dis
 * Зовёт сам: __ld_r13_to_r13_ret, ba_sm_evt_type, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__ba_disable
stream_mgr__ba_disable:
	.global L_8c4200
L_8c4200:
	push_s blink
L_8c4202:
	push_s r13
L_8c4204:
	mov_s r1,0x847f34
L_8c420a:
	sub r1,r1,0x400
L_8c420e:
	add2_s r1,r1,r0
L_8c4210:
	ld r13,[r1,0x44c]
L_8c4218:
	breq_s r13,0,L_8c4232
	.global L_8c421a
L_8c421a:
	mov_s r0,0x0
L_8c421c:
	st_s r0,[r13,0x54]
L_8c421e:
	mov_s r0,r13
L_8c4220:
	mov_s r1,0x1
L_8c4222:
	mov_s r2,0x25
L_8c4224:
	mov_s r3,r1
L_8c4226:
	bl.d L_8d9c4c
L_8c422a:
	mov r4,0x0
L_8c422e:
	b L_8c025c
	.global L_8c4232
L_8c4232:
	mov_s r0,blink
L_8c4234:
	mov_s r1,0x128c
L_8c423a:
	bl L_8c9b28
L_8c423e:
	b_s L_8c421a
