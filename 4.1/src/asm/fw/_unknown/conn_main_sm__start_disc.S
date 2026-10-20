/* conn_main_sm__start_disc @ 0x8e275c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm::start_disc() - Starting disconnection
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__inject_event, conn_main_sm__report_disc_state, fw_log__emit0, u_schd__cancel
 */
	.section .text.conn_main_sm__start_disc,"ax",@progbits
	.global conn_main_sm__start_disc
conn_main_sm__start_disc:
L_8e275c:
	push_s blink
L_8e275e:
	bl L_8c02bc
L_8e2762:
	mov_s r14,r0
L_8e2764:
	mov_s r16,r1
L_8e2766:
	mov_s r15,r2
L_8e2768:
	mov_s r2,0x100f808
L_8e276e:
	mov_s r0,0xb
L_8e2770:
	bl.d L_8edfb0
L_8e2774:
	mov_s r1,0x2
L_8e2776:
	mov_s r13,0x0
L_8e2778:
	ld_s r0,[r14,0x74]
L_8e277a:
	st r13,[r14, 0x80]
L_8e277e:
	st_s r13,[r14,0x7c]
L_8e2780:
	breq_s r0,0,L_8e2788
L_8e2782:
	bl L_8c7794
L_8e2786:
	st_s r13,[r14,0x74]
	.global L_8e2788
L_8e2788:
	bl.d L_8eb504
L_8e278c:
	ld_s r0,[r14,0x2c]
L_8e278e:
	add r0,r14,0x30
L_8e2792:
	mov_s r1,0x0
L_8e2794:
	mov_s r2,r16
L_8e2796:
	mov_s r3,r15
L_8e2798:
	bl.d L_8d6a1c
L_8e279c:
	mov_s r4,r1
L_8e279e:
	b L_8c0324
L_8e27a2:
	nop_s
