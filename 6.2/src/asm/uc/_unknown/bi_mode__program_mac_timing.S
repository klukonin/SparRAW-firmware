/* bi_mode__program_mac_timing @ 0x936a94, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_mode__program_mac_timing
bi_mode__program_mac_timing:
	.global L_936a94
L_936a94:
	mov_s r1,0x887000
L_936a9a:
	mov_s r0,0x886d00
L_936aa0:
	st 0x40063,[r0, 0x5c]
L_936aa8:
	st 0x10001,[r0, 0x60]
L_936ab0:
	st.as 0x60025,[r1,-0x86]
L_936ab8:
	st.as 0x2000b,[r1,-0x85]
L_936ac0:
	st 0x5300a5,[r0, 0x58]
L_936ac8:
	j_s [blink]
L_936aca:
	nop_s
