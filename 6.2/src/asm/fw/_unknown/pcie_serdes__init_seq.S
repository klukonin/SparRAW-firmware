/* pcie_serdes__init_seq @ 0x8f344c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: conn__inject_evt4, conn_mgr__by_cid, hwd_pcie_exit_l1, hwd_pcie_l1_sub_timing_config, pcie__fix_max_read_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_serdes__init_seq
pcie_serdes__init_seq:
	.global L_8f344c
L_8f344c:
	push_s blink
L_8f344e:
	bl.d L_8d12ac
L_8f3452:
	mov_s r0,0x1
L_8f3454:
	bl L_8d1864
L_8f3458:
	bl L_8d169c
L_8f345c:
	bl.d L_8d12ac
L_8f3460:
	mov_s r0,0x0
L_8f3462:
	pop_s blink
L_8f3464:
	j_s [blink]
L_8f3466:
	nop_s
L_8f3468:
	push_s blink
L_8f346a:
	bl L_8cbffc
L_8f346e:
	bl L_8cb69c
L_8f3472:
	pop_s blink
L_8f3474:
	j_s [blink]
L_8f3476:
	nop_s
