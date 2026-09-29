/* u_schd__deadline_less @ 0x8ca070, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__calc_next_deadline, u_schd__run_expired
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.u_schd__deadline_less,"ax",@progbits
	.global u_schd__deadline_less
u_schd__deadline_less:
	.global L_8ca070
L_8ca070:
	push_s blink
L_8ca072:
	push_s r13
L_8ca074:
	ld_s r2,[r0,0x4]
L_8ca076:
	mov_s r13,r1
L_8ca078:
	cmp_s r2,0x0
L_8ca07a:
	mov.eq r0,0x0
L_8ca07e:
	beq_s L_8ca08c
L_8ca080:
	ld_s r1,[r0,0x10]
L_8ca082:
	ld_s r3,[r1,0x4]
L_8ca084:
	jl_s.d [r3]
L_8ca086:
	ld_s r1,[r2,0x8]
L_8ca088:
	st_s r0,[r13]
L_8ca08a:
	mov_s r0,0x1
	.global L_8ca08c
L_8ca08c:
	b L_8c033c
