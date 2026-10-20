/* bi_ap_mon__init @ 0x928130, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_bi_ap_mon__init
 * Зовёт сам: uc_basic_sm__setup
 * Глобалы (через gp): 0x8005c4
 */
	.section .text.bi_ap_mon__init,"ax",@progbits
	.global bi_ap_mon__init
bi_ap_mon__init:
	.global L_928130
L_928130:
	st.a r13,[sp,-0x8]
L_928134:
	st_s r14,[sp,0x4]
L_928136:
	mov_s r14,blink
L_928138:
	mov_s r13,r0
L_92813a:
	mov_s r3,0x800adc
L_928140:
	mov r4,0x800b40
L_928148:
	mov r5,0x800b54
L_928150:
	ld.as r1,[gp,0x27]
L_928154:
	mov r2,0x2
L_928158:
	mov r6,0x5
L_92815c:
	bl.d L_928174
L_928160:
	mov r7,0x4
L_928164:
	mov_s r0,0x1
L_928166:
	st_s r0,[r13,0x28]
L_928168:
	mov_s blink,r14
L_92816a:
	ld_s r14,[sp,0x4]
L_92816c:
	j.d [blink]
L_928170:
	ld.ab r13,[sp,0x8]
