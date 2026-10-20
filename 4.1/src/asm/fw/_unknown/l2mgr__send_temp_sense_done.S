/* l2mgr__send_temp_sense_done @ 0x8e10d8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TEMP_SENSE_DONE_EVENTID: Baseband=%d[mili-Celcius] RF=%d[mili-Celcius]
 * Зовут его: wmi_handler_temp_sense
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit2
 */
	.section .text.l2mgr__send_temp_sense_done,"ax",@progbits
	.global l2mgr__send_temp_sense_done
l2mgr__send_temp_sense_done:
	.global L_8e10d8
L_8e10d8:
	push_s blink
L_8e10da:
	bl L_8c02bc
L_8e10de:
	mov_s r14,r0
L_8e10e0:
	mov_s r16,r1
L_8e10e2:
	mov_s r15,r2
L_8e10e4:
	bl.d L_8c2c38
L_8e10e8:
	mov_s r0,r2
L_8e10ea:
	mov_s r13,r0
L_8e10ec:
	st_s r14,[r0]
L_8e10ee:
	st r16,[r0, 0x4]
L_8e10f2:
	mov_s r2,0x1006010
L_8e10f8:
	mov_s r0,0x0
L_8e10fa:
	mov_s r1,0x2
L_8e10fc:
	mov_s r3,r14
L_8e10fe:
	bl.d L_8edff8
L_8e1102:
	mov r4,r16
L_8e1106:
	mov_s r0,r15
L_8e1108:
	mov_s r1,r13
L_8e110a:
	mov_s r2,0x0
L_8e110c:
	mov_s r3,0x180e
L_8e1112:
	mov r4,0x8
L_8e1116:
	mov r5,0x0
L_8e111a:
	mov r6,0x0
L_8e111e:
	bl.d L_8e0460
L_8e1122:
	mov r7,0x0
L_8e1126:
	b L_8c0324
L_8e112a:
	nop_s
