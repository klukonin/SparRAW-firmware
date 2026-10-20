/* uc_evt__enqueue @ 0x927958, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__send_20, uc_evt__send_21, uc_evt__send_22, uc_evt__send_23, uc_evt__send_24, uc_evt__send_25, uc_evt__send_26, uc_evt__send_29_sync, uc_evt__send_2b, uc_evt__send_2c_tsf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__read_tsf64_uc, uc_evt__queue_put
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__enqueue
uc_evt__enqueue:
	.global L_927958
L_927958:
	push_s blink
L_92795a:
	bl L_920230
L_92795e:
	sub_s sp,sp,0x10
L_927960:
	mov_s r14,r0
L_927962:
	mov_s r13,r1
L_927964:
	mov_s r15,r2
L_927966:
	st_s r3,[sp,0x4]
L_927968:
	bl.d L_9356cc
L_92796c:
	add_s r0,sp,0x8
L_92796e:
	mov_s r3,0x0
L_927970:
	st_s r3,[sp,0x0]
L_927972:
	mov_s r0,0x802470
L_927978:
	mov_s r1,r14
L_92797a:
	mov_s r2,r13
L_92797c:
	mov_s r4,r15
L_92797e:
	ld r5,[sp, 0x4]
L_927982:
	mov_s r6,r3
L_927984:
	bl.d L_9349dc
L_927988:
	mov_s r7,r3
L_92798a:
	mov r1,0x200
L_92798e:
	mov_s r0,0x880b00
L_927994:
	st_s r1,[r0,0x58]
L_927996:
	sync
L_92799a:
	b.d L_92029c
L_92799e:
	add_s sp,sp,0x10
